import { axios } from "src/boot/axios";
import { useRoute, useRouter } from "vue-router";
import { LoadingBar } from "quasar";
import { store } from "quasar/wrappers";
import { useNotification } from "naive-ui";
import {
  setPaginationFunc,
  paginationObject,
  getPaginationFunc,
} from "/src/helper/pagination";

export default {
  state: {
    novella: {},
    novellaList: [],
    publicNewNovells: [],
    publicNovella: {},
    ...paginationObject(1, 9),
  },
  getters: {
    getStateNovela(state) {
      return state;
    },
    ...getPaginationFunc("Novella"),
  },
  mutations: {
    ...setPaginationFunc("Novella"),
  },
  actions: {
    async createNewNovella({ state, commit }, novella) {
      const result = await axios.post("/novella", novella);

      state.novella = result.data.novella;
    },
    async getNovellaByParams({ state, commit }, params) {
      const result = await axios.get("/novella/attrs", {
        params,
      });

      state.novella = result.data.novella;
    },
    async getAllNovella({ state, commit }, novella) {
      const result = await axios.get("/novella");

      state.novellaList = result.data.novella;
    },
    async getPublicNewNovella({ state, commit }) {
      const result = await axios.get("/public/novella_news");

      state.publicNewNovells = result.data.novella;
    },
    async getPublicNovellaById({ state }, id) {
      const result = await axios.get(`/public/novella/${id}`);

      state.publicNovella = result.data;
    },
    async getPublicsAllNovella({ state }, params) {
      const { page, limit } = state;
      // const { search } = params;

      if (params.value != undefined) {
        params = params.value;
      }
      const result = await axios.get("/public/novella", {
        params: {
          page,
          limit,
          search: params["search"] || "",
        },
      });

      state.totalPage = Math.ceil(result.data.count / limit);

      state.novellaList = result.data.novella;
    },
  },
};
