import { axios } from "src/boot/axios";
export default {
  state: {
    views: {},
  },

  actions: {
    async getLikeByAttr({ state }, attrs) {
      const result = await axios.get(`/views/attrs`, {
        params: attrs,
      });
      state.views = result.data.views;
    },
  },
};
