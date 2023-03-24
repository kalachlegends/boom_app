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
    component: {},
    components: [],
    ...paginationObject(1, 9),
  },
  getters: {
    ...getPaginationFunc("Component"),
  },
  mutations: {
    setAllComponents(state, components) {
      state.components = helperAddSelected(components);
    },
    ...setPaginationFunc("Component"),
  },
  actions: {
    async createComponent({ state }, attrs) {
      await axios.post("/component", attrs).then((result) => {
        state.component = result.data.component;
      });
    },
    async fecthAllComponets({ commit, state }, params = {}) {
      const { page, limit } = state;

      const result = await axios.get("/component/attrs", {
        params: {
          page,
          limit,
          novella_id: params["novella_id"],
        },
      });

      state.totalPage = Math.ceil(result.data.count / limit);

      commit("setAllComponents", result.data.component);
    },
  },
};
