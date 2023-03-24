import { Toast } from "src/helper/defaultAlert";

import { onMounted, inject, ref, onUnmounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
export const usePreviewNovella = (drawFunction) => {
  const store = useStore();
  const route = useRoute();
  const slide = ref({
    currentSlide: 0,
    lastSlide: 0,
  });
  const router = useRouter();
  const titleEvent = ref("");
  const isModal = ref(false);
  const slideArr = ref([]);
  const events = ref([]);
  const solutions = ref([]);
  const workspace = ref({
    elements: [],
  });
  // const isLoad = inject("isLoad");
  const loadTreeFunction = async (tree_id) => {
    solutions.value = [];
    // isLoad.value = true;
    await store.dispatch("fetchPreviewTree", tree_id);

    slideArr.value = store.state.tree.treeArr;

    workspace.value = store.state.tree.treeArr[0].slide.workspace_json;
    slide.value.currentSlide = 0;
    slide.value.lastSlide = store.state.tree.treeArr.length;
    // isLoad.value = false;
    setTimeout(drawFunction.value, 20);
  };
  onMounted(async () => {
    const { tree_id } = route.params;
    await loadTreeFunction(tree_id);
    // drawFunction();
  });
  const checkEvents = () => {
    const currentSlide = slideArr.value[slide.value.currentSlide];
    if (currentSlide.event != null) {
      isModal.value = true;
      events.value = currentSlide.event.arr_events;
      titleEvent.value = currentSlide.event.name;
      throw "NEW EVENT!";
    }
  };
  const checkSlideLastSlide = () => {
    const { currentSlide, lastSlide } = slide.value;

    if (currentSlide != lastSlide - 1) {
      return true;
    } else {
      return false;
    }
  };
  async function handleNext() {
    checkEvents();
    if (checkSlideLastSlide()) {
      workspace.value =
        slideArr.value[slide.value.currentSlide + 1].slide.workspace_json;
      slide.value.currentSlide++;

      setTimeout(drawFunction.value, 20);
    } else {
      const curentSolition = solutions.value;
      if (solutions.value.length != 0) {
        const tree_id_arr = curentSolition
          .map((el) => {
            return el.tree_id;
          })
          .filter(onlyUnique);
        const result = {};
        tree_id_arr.forEach(
          (el) =>
            (result[el] = {
              tree_id: el,
              point: 0,
            })
        );

        curentSolition.forEach((elem) => {
          const tree_id = tree_id_arr.find((el) => el == elem.tree_id);

          result[tree_id].point = parseInt(elem.point) + result[tree_id].point;
        });

        const tree = Object.values(result).sort((a, b) => a.point - b.point)[0];

        const { novella_id } = route.params;
        await loadTreeFunction(tree.tree_id);
        router.push("/novella/preview/" + novella_id + "/" + tree.tree_id);
      } else {
        Toast.fire({
          title: "The story is over",
        });
      }
    }
  }
  async function handleKeyDown(e) {
    if (e.keyCode == 39) {
      await handleNext();
    }
    if (e.keyCode == 37) {
      // handlePrev()
    }
  }
  onMounted(() => {
    document.addEventListener("keydown", handleKeyDown);
  });
  onUnmounted(() => {
    document.removeEventListener("keydown", handleKeyDown);
  });
  const handlePrev = () => {};
  const handleClickEvent = (index) => {
    solutions.value.push(events.value[index]);
    isModal.value = false;
    slideArr.value[slide.value.currentSlide].event = null;
    handleNext();
  };

  return {
    isModal,
    handleClickEvent,
    handleNext,
    events,
    workspace,
    titleEvent,
    slide,
  };
  // slideName: computed(() => slideArr.value[slide.value.currentSlide].name)
};

function onlyUnique(value, index, self) {
  return self.indexOf(value) === index;
}
function max(list) {
  return list.reduce((a, b) => (a > b ? a : b));
}
