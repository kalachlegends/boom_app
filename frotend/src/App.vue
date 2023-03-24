<template>
  <n-notification-provider>
    <n-message-provider>
      <AppLayoutVue>
        <router-view />
      </AppLayoutVue>
    </n-message-provider>
  </n-notification-provider>
</template>
<style>
</style>


<script>
import AppLayoutVue from "./layouts/AppLayout.vue";
import { defineComponent } from "vue";

export default defineComponent({
  name: "App",
  components: {
    AppLayoutVue,
  },
});
</script>
