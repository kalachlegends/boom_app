import { ref } from "vue";
import { useStore } from "vuex";

export const useCreateComponent = () => {
  const store = useStore();
  const isLoad = ref(false);
  const handleCreateComponent = async (attrs) => {
    isLoad.value = false;

    await store.dispatch("createComponent", attrs);
    isLoad.value = true;
  };
  return [handleCreateComponent, isLoad];
};
