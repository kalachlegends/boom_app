import { axios } from "src/boot/axios";
import { defineEmits, ref, onMounted } from "vue";
export const usePagination = (callbackAction, callbackSetPage, params = {}) => {
  const isLoad = ref(false);

  const callbackFunction = async () => {
    isLoad.value = true;
    await callbackAction();
    isLoad.value = false;
  };
  onMounted(async () => {
    if (params["isMounted"] != undefined && params["isMounted"] != false) {
      await callbackFunction();
    }
  });
  const changePage = async (page) => {
    isLoad.value = true;
    if (page != undefined || page != null) {
      callbackSetPage(page);
    }
    await callbackFunction(page);
    isLoad.value = false;
  };
  return {
    changePage,
    isLoad,
  };
};
