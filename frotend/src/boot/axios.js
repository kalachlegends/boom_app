import { boot } from "quasar/wrappers";
import axioss from "axios";
import { Toast } from "src/helper/defaultAlert";
import { LocalStorage } from "quasar";
// Be careful when using SSR for cross-request state pollution
// due to creating a Singleton instance here;
// If any client changes this (global) instance, it might be a
// good idea to move this instance creation inside of the
// "export default () => {}" function below (which runs individually
// for each client)
export let baseURL = import.meta.env.VITE_BASE_URL;

const axios = axioss.create({ baseURL });

export default boot((boot) => {
  // for use inside Vue files (Options API) through this.$axios and this.$api

  axios.defaults.headers.common["Authorization"] =
    LocalStorage.getItem("token") || "";
  axios.interceptors.response.use(
    (response) => {
      return response;
    },
    (error) => {
      if (error.response.status == 401) {
        window.location.pathname = "/login";
        LocalStorage.remove("token");
        LocalStorage.remove("user");
      }
      if (error.response.status == 429) {
        Toast.fire({
          title: "To many request please wait",
          icon: "error",
        });
      }
      return Promise.reject(error);
    }
  );
  boot.app.config.globalProperties.$axios = axios;

  //
  //

  // ^ ^ ^ this will allow you to use this.$axios (for Vue Options API form)
  //       so you won't necessarily have to import axios in each vue file

  // ^ ^ ^ this will allow you to use this.$api (for Vue Options API form)
  //       so you can easily perform requests against your app's API
});

export { axios };
