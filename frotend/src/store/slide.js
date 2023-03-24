import { axios } from "src/boot/axios";
import { useRoute, useRouter } from "vue-router";
import { normalizeBooleanArray } from "src/helper/mapNormalizeBoolean";
export default {
  state: {
    prevSlide: {},
    currentSlide: {},
    nextSlide: {},
  },
  getters: {
    getElements(state) {
      return state.currentSlide.workspace_json.elements;
    },
  },
  mutations: {
    setElements() {},
  },
  actions: {
    async createNewSlide({ state, commit }, slide) {
      const result = await axios.post("/slide", slide);

      state.prevSlide = normalizeBooleanArray(state.currentSlide);
      state.currentSlide = normalizeBooleanArray(result.data.slide);
      state.nextSlide = null;
    },
    async getSlidesById({ state, commit }, params) {
      const result = await axios.get("/slide/" + params.id, {
        params,
      });

      state.nextSlide = normalizeBooleanArray(result.data.slide_next);
      state.currentSlide = normalizeBooleanArray(result.data.slide_current);
      state.prevSlide = normalizeBooleanArray(result.data.slide_prev);
    },
    async updateSlide({ state, commit }, params) {
      const result = await axios.patch("/slide/" + params.id, params);

      state.currentSlide = normalizeBooleanArray(result.data.slide);
    },
  },
};
