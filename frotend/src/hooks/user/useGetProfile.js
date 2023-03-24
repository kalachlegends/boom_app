import { useRouter, useRoute } from "vue-router";
import { useStore } from "vuex";
import { ref, onMounted, computed, inject } from "vue";

export const useGetProfile = () => {
  const route = useRoute();

  const store = useStore();
  onMounted(async () => {
    await store.dispatch("fetchProfileByUserLogin", route.params.login);
  });

  return {
    user: computed(() => store.getters.getProfile),
  };
};
