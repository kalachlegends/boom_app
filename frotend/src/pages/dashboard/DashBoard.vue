<template>
  <div class="tw-flex tw-justify-items-end tw-justify-start tw-pb-6">
    <CreateIncidentVue />
  </div>
  <div class="tw-flex tw-gap-3 tw-justify-between tw-min-h-full tw-h-full">
    <n-card title="Неактивные" size="medium" class="tw-h-full">
      <CardTaskVue />
    </n-card>
    <n-card title="Активные" size="medium" class="tw-h-full"> </n-card>
    <n-card title="Готовые" size="medium" class="tw-h-full"> </n-card>
    <n-card title="Удалённые" size="medium" class="tw-h-full"> </n-card>
  </div>
</template>

<script setup>
  import CardTaskVue from "../../components/dashboard/CardTask.vue";
  import CreateIncidentVue from "../../components/incident/CreateIncident.vue";
</script>

<style lang="scss" scoped>

</style>