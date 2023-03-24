import { axios } from "src/boot/axios";
export default {
  state: {
    likePublic: {},
  },

  actions: {
    async getLikeByAttr({ state }, attrs) {
      const result = await axios.get(`/like`, {
        params: attrs,
      });

      state.likePublic = result.data.like;
    },
    async setLikeNovella({ state }, params) {
      const result = await axios.post(`/like`, params);

      state.likePublic = result.data.like_item;
    },
  },
};
