import { axios } from "src/boot/axios";
import { useRoute, useRouter } from "vue-router";

export default {
  state: {
    user: {
      login: "",
    },
    currentUser: {},
    isAuth: false,
  },
  getters: {
    getProfile(state) {
      return state.user;
    },
    getCurrentUser(state) {
      return state.currentUser;
    },
    getIsAuth(state) {
      return state.isAuth;
    },
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
    },
    setCurrentUser(state, user) {
      state.currentUser = user;
    },
    setAuth(state, isAuth) {
      state.isAuth = isAuth;
    },
  },
  actions: {
    async fetchProfileByUserLogin({ state, commit }) {
      const router = useRouter();
      const route = useRoute();

      await axios
        .get("/user/profile/" + route.params.login)
        .then((res) => {
          commit("setUser", res.data.user);
        })
        .catch((e) => {
          //   router.push({
          //     name: "404",
          //   });
        });
    },
    async fetchProfileByUserId({ state, commit }, id) {
      await axios
        .get("/user/" + id)
        .then((res) => {
          commit("setUser", res.data.user);
        })
        .catch((e) => {});
    },
  },
};
