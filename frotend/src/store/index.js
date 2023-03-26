import { createStore } from "vuex";
import { store } from "quasar/wrappers";
import user from "./user";
import image from "./image";
import like from "./like";

export default store((/* { ssrContext } */) => {
  const store = createStore({
    state: {
      movementAll: [],
    },
    getters: {},
    mutations: {},
    actions: {
      async setLikeNovella({ state }, params) {
        const result = await axios.post(`/like`, params);

        state.likePublic = result.data.like_item;
      },
    },
    modules: {
      user,
      image,

      like,
    },
  });

  return store;
});
