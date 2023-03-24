import { axios } from "src/boot/axios";

export default {
  state: {
    event: {
      name: "Unitled Event",
      arr_events: [],
    },
  },
  getters: {
    isUpdateEvent(state) {
      if (state.event.arr_events != undefined) {
        return state.event.arr_events.length == 0;
      }
      return false;
    },
  },
  mutations: {},
  actions: {
    async createNewEvent({ state, commit }, attrs) {
      const result = await axios.post("/event", attrs);

      state.event = result.data.event;
    },
    async fetchEventBySlideId({ state, commit }, slide_id) {
      try {
        const result = await axios.get("/event/slide_id/" + slide_id);

        state.event = result.data.event;
      } catch (e) {
        state.event = {
          name: "Unitled Event",
          arr_events: [],
        };
      }
    },
    async updateEvent({ state, commit }, attrs) {
      const result = await axios.patch("/event", attrs);

      state.event = result.data.event;
    },
  },
};
