import { useStore } from "vuex";
import { computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { Toast } from "src/helper/defaultAlert";
export const useSlide = (elements, parentElement) => {
  const store = useStore();
  const router = useRouter();
  const route = useRoute();
  const { slide_id, tree_id } = route.params;
  const prevSlide = computed(() => store.state.slide.prevSlide);
  const currentSlide = computed(() => store.state.slide.currentSlide);
  const nextSlide = computed(() => store.state.slide.nextSlide);
  onMounted(async () => {
    await store.dispatch("getSlidesById", {
      id: slide_id,
      tree_id,
    });
    elements.value = store.state.slide.currentSlide.workspace_json.elements;

    // setInterval(async () => {
    //     const { slide_id, tree_id } = route.params
    //     await store.dispatch("updateSlide", {
    //         id: slide_id,
    //         workspace: parentElement.value.outerHTML,
    //         workspace_json: {
    //             elements: elements.value
    //         },
    //     })
    // }, 7000);
  });
  const handlePrevClick = async () => {
    if (store.state.slide.prevSlide == null) {
      Toast.fire({
        title: "НЕЛЬЗЯ ПЕРЕЙТИ ДАЛЬШЕ!",
      });
    } else {
      const { slide_id, tree_id } = route.params;

      await store.dispatch("updateSlide", {
        id: slide_id,
        tree_id,
        workspace_json: {
          elements: elements.value,
        },
      });

      elements.value = store.state.slide.prevSlide.workspace_json.elements;
      router.push({
        name: "editor",
        params: { slide_id: store.state.slide.prevSlide.id },
      });
      await store.dispatch("getSlidesById", {
        id: store.state.slide.prevSlide.id,
        tree_id,
      });
    }
  };

  const handleNextClick = async () => {
    if (store.state.slide.nextSlide == null) {
      const { slide_id, tree_id } = route.params;
      await store.dispatch("updateSlide", {
        id: slide_id,
        tree_id,
        workspace_json: {
          elements: elements.value,
        },
      });
      await store.dispatch("createNewSlide", {
        id: slide_id,
        tree_id,
      });
      elements.value = [];
      router.push({
        name: "editor",
        params: { slide_id: store.state.slide.currentSlide.id },
      });
    } else {
      const { slide_id, tree_id } = route.params;

      await store.dispatch("updateSlide", {
        id: slide_id,
        tree_id,
        workspace_json: {
          elements: elements.value,
        },
      });
      elements.value = store.state.slide.nextSlide.workspace_json.elements;

      router.push({
        name: "editor",
        params: { slide_id: store.state.slide.nextSlide.id },
      });
      await store.dispatch("getSlidesById", {
        id: store.state.slide.nextSlide.id,
        tree_id,
      });

      // store.state.slide.currentSlide = store.state.slide.nextSlide
      // store.state.slide.prevSlide = store.state.slide.currentSlide
    }
  };
  const saveSlide = async () => {
    const { slide_id, tree_id } = route.params;

    await store.dispatch("updateSlide", {
      id: slide_id,
      tree_id,
      workspace_json: {
        elements: elements.value,
      },
    });
    Toast.fire({
      title: "Успешно сохранено",
      icon: "success",
    });
  };
  return {
    handleNextClick,
    handlePrevClick,
    currentSlide,
    saveSlide,
  };
};
