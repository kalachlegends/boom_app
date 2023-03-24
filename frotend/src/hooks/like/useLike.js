import { Toast } from "src/helper/defaultAlert";
import { computed, ref } from "vue";
import { useStore } from "vuex";

export const useLike = (params = {}) => {
  const isLoad = ref(false);
  const store = useStore();

  const isAuth = computed(() => store.getters.getIsAuth);
  const handleLike = async (type_like) => {
    if (isAuth.value) {
      isLoad.value = false;
      await store
        .dispatch("setLikeNovella", {
          type_parent: params["type_parent"],
          parent_id: params["parent_id"],
          type_like,
        })
        .catch((e) => {
          Toast.fire({
            title: "You have already rated",
            icon: "error",
          });
        });
    } else {
      Toast.fire({
        title: "Sign  in to like",
        icon: "error",
      });
    }
    isLoad.value = true;
  };

  return [handleLike, isLoad];
};
