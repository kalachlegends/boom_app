import { useStore } from "vuex";
import { computed, ref, onMounted } from "vue";
import { usePagination } from "src/hooks/usePagination";
export const useGetAllImage = (params = {}) => {
  const store = useStore();

  const { changePage, isLoad } = usePagination(
    async () => await store.dispatch("fecthAllImages", params),
    (page) => store.commit("setImagePagePagination", page)
  );

  onMounted(async () => {
    await store.dispatch("fecthAllImages", params);
  });
  return [
    computed(() => store.getters.getImagePagePagination),
    isLoad,
    computed(() => store.getters.getImageTotalPagePagination),

    changePage,
    computed(() => store.getters.getAllImages),
  ];
};
