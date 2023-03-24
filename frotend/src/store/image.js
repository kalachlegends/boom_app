import { axios } from "src/boot/axios";
import { useRoute, useRouter } from "vue-router";
import { helperAddSelected } from "src/hooks/useSelected";
import {
  setPaginationFunc,
  paginationObject,
  getPaginationFunc,
} from "src/helper/pagination";
export default {
  state: {
    images: [],
    image_random_link:
      "http://localhost:10615/images/anime/DALL·E 2022-12-21 09.32.57 - Book with stars painted in oil and in cosmos.png",
    ...paginationObject(1, 6),
  },
  getters: {
    getAllImages(state) {
      return state.images;
    },
    ...getPaginationFunc("Image"),
  },
  mutations: {
    setAllImages(state, images) {
      state.images = helperAddSelected(images);
    },
    ...setPaginationFunc("Image"),
  },
  actions: {
    async fecthAllImages({ commit, state }, params = {}) {
      const { page, limit } = state;

      const result = await axios.get("/image/get_all", {
        params: {
          page,
          limit,
          table_type: params["table_type"],
        },
      });

      state.totalPage = Math.ceil(result.data.count / limit);

      commit("setAllImages", result.data.images);
    },
    async fecthRandomImg({ commit, state }) {
      const { page, limit } = state;

      const result = await axios.get("/image/random");

      state.image_random_link = result.data.image;
    },
  },
};
