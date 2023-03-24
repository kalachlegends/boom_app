import { axios } from "src/boot/axios";
import { useRoute, useRouter } from "vue-router";
import { parseTree, traverse } from "src/helper/parse-tree";

export default {
  state: {
    treeArr: [],
    objectTree: {},
    treePublic: [],
    publicTreeOne: {},
  },
  getters: {},
  mutations: {
    setTreeArr(state, tree) {
      state.treeArr = tree;
      state.objectTree = parseTree(tree)[0];
    },
    setNewTree(state, tree) {
      state.treeArr = [...state.treeArr, tree];
      state.objectTree = parseTree(state.treeArr)[0];
    },
  },
  actions: {
    async fetchAllTreeById({ state, commit }, tree_id) {
      const result = await axios.get("/tree/tree_id/" + tree_id);

      state.treeArr = result.data.tree;
    },

    async fetchPreviewTree({ state, commit }, tree_id) {
      const result = await axios.get("/tree/preview/" + tree_id);

      state.treeArr = result.data.tree;
    },
    async fetchAllTree({ state, commit }, novella_id) {
      const result = await axios.get("/tree/novella/" + novella_id);

      commit("setTreeArr", result.data.tree);
    },
    async fetchAllTreePublic({ state, commit }, novella_id) {
      const result = await axios.get("/public/tree/", {
        params: {
          novella_id: novella_id,
        },
      });
      //

      state.treePublic = result.data.tree;
      state.publicTreeOne = result.data.tree[0];
    },
    async fetchCreateTree({ state, commit }, object) {
      const result = await axios.post("/tree/", {
        tree_id: object.id,
        novella_id: object.novella_id,
      });

      commit("setNewTree", result.data.tree);
    },
  },
};
