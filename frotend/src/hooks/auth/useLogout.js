// import { ref, useRouter } from "vue";
import { axios } from "src/boot/axios.js";
import { Toast } from "src/helper/defaultAlert";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { LocalStorage } from "quasar";
export const useLogout = () => {
  const store = useStore();
  const router = useRouter();
  const handleLogout = () => {
    store.state.user.isAuth = false;
    LocalStorage.remove("token");
    LocalStorage.remove("user");
    store.state.user.isAuth = false;
    store.state.user.currentUser = {};
    router.push("/login");
  };
  return {
    handleLogout,
  };
};
