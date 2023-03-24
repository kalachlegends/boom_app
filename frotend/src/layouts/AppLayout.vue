<script setup >
import AppLayoutDefault from "./AppLayoutDefault.vue";
import AppLayoutAdmin from "./AppLayoutAdmin.vue";
import AppLayoutMain from "./AppLayoutMain.vue";
import { markRaw, ref, watchEffect } from "vue";
import { useRoute } from "vue-router";

const layout = ref();
const route = useRoute();

watchEffect(async () => {
  try {
    const layouts = [
      {
        name: "AppLayoutAdmin",
        layout: AppLayoutAdmin,
      },

      { name: "AppLayoutMain", layout: AppLayoutMain },
    ];
    const metaLayout = route.meta.layout;

    const component = layouts.find((e) => metaLayout == e.name);
    if (component == undefined) {
      throw "component undifned";
    }
    layout.value = markRaw(component.layout || AppLayoutDefault);
  } catch (e) {
    layout.value = markRaw(AppLayoutDefault);
  }
});
</script>

<template>
  <component :is="layout"> <router-view /> </component>
</template>