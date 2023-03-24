import { Toast } from "src/helper/defaultAlert";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import { ref, onMounted, computed } from "vue";
import { useContextMenu } from "src/hooks/other/useContextMenu";
export const useEvent = () => {
  const store = useStore();
  const route = useRoute();
  const titleEvent = ref("Title Event");
  const arrEvents = ref([]);
  const isModalNewEvent = ref(false);
  const { itemsContext, handleContext, callContext } = useContextMenu([]);

  const defaultEvent = ref({
    name: "",
    tree_id: 0,
    tree_name: "Tree",
    point: "10",
  });
  onMounted(async () => {
    await store.dispatch("fetchAllTreeById", route.params.tree_id);
    itemsContext.value = store.state.tree.treeArr.map((el) => {
      return {
        ...el,
        callback: ([index], item) => {
          arrEvents.value[index].tree_id = item.id;
          arrEvents.value[index].tree_name = item.name;
        },
      };
    });
    titleEvent.value = store.state.event.event.name;
  });
  const handleOpenModel = async () => {
    try {
      if (store.state.tree.treeArr.length == 0)
        throw new Error("Create a branch from this tree");
      await store.dispatch("fetchEventBySlideId", route.params.slide_id);
      const tree = store.state.tree.treeArr[0];
      titleEvent.value = store.state.event.event.name;
      isModalNewEvent.value = true;

      defaultEvent.value.tree_id = tree.id;
      defaultEvent.value.tree_name = tree.name;
      if (store.getters.isUpdateEvent) {
        arrEvents.value = [{ ...defaultEvent.value }];
      } else {
        arrEvents.value = store.state.event.event.arr_events;
      }
    } catch (e) {
      Toast.fire({
        title: "Not Found Tree",
        text: e,
        icon: "error",
      });
    }
  };
  const handleAddNewEvent = () =>
    arrEvents.value.push({ ...defaultEvent.value });
  const handleSave = async () => {
    if (!store.getters.isUpdateEvent) {
      await store.dispatch("updateEvent", {
        ...store.state.event.event,
        name: titleEvent.value,
        slide_id: route.params.slide_id,
        arr_events: arrEvents.value,
      });
      Toast.fire({
        title: "Update you Event!",
        icon: "success",
      });
    } else {
      await store.dispatch("createNewEvent", {
        name: titleEvent.value,
        slide_id: route.params.slide_id,
        arr_events: arrEvents.value,
      });
      Toast.fire({
        title: "Create new Event!",
        icon: "success",
      });
    }
    isModalNewEvent.value = false;
  };

  return {
    handleSave,
    titleEvent,
    handleOpenModel,
    arrEvents,
    handleAddNewEvent,
    isModalNewEvent,
    itemsContext,
    handleContext,
    callContext,
  };
};
