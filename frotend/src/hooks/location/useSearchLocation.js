import axios from "src/boot/axios";
import { ref, watch } from "vue";

export const useSearchLocation = () => {
  const searchValue = ref("");
  const locations = ref([]);
  const isLoad = ref(false);
  watch([searchValue], (newValue) => {
    axios.get("/location", {
      params: {
        sample: newValue,
      },
    });
  });
};
