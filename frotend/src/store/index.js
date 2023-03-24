import { createStore } from "vuex";
import { store } from "quasar/wrappers";
import user from "./user";
import image from "./image";
import like from "./like";

export default store((/* { ssrContext } */) => {
  const store = createStore({
    state: {},
    getters: {},
    mutations: {},
    actions: {},
    modules: {
      user,
      image,

      like,
    },
  });

  return store;
});
