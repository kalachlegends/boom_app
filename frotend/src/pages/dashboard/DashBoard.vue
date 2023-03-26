<template>
  <div class="tw-flex tw-justify-items-end tw-justify-start tw-pb-6">
    <CreateIncidentVue v-if="!isCreateIncident" />
  </div>
  <LiostIncidnet />
</template>

<script setup>
import { ref } from "vue";
import CreateIncidentVue from "../../components/incident/CreateIncident.vue";
import LiostIncidnet from "../../components/incident/LiostIncidnet.vue";
const org = JSON.parse(localStorage.getItem("org"));
const isCreateIncident = ref(false);
if (org) {
  isCreateIncident.value = true;
}
</script>

<style lang="scss" scoped>
</style>