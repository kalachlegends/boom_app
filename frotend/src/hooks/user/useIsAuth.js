import { LocalStorage } from "quasar";
import { useStore } from "vuex";
import { computed, onMounted } from "vue";
export const useIsAuth = () => {
  const store = useStore();
  const token = LocalStorage.getItem("token");
  onMounted(() => {
    if (token == "" || token == undefined) {
      store.commit("setAuth", false);
    } else {
      const user = JSON.parse(LocalStorage.getItem("user"));

      store.commit("setAuth", true);
      store.commit("setCurrentUser", user);
    }
  });

  return {
    isAuth: computed(() => store.getters.getIsAuth),
    user: computed(() => store.getters.getCurrentUser),
  };
};
