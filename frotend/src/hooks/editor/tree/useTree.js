import { onMounted, computed } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
export const useTree = () => {
  const store = useStore();
  const route = useRoute();

  onMounted(async () => {
    await store.dispatch("fetchAllTree", route.params.novella_id);
  });

  const handleNewTree = async ([object]) => {
    store.dispatch("fetchCreateTree", object);
  };
  return {
    handleNewTree,
    objectTree: computed(() => store.state.tree.objectTree),
  };
};
