<template>
  <div class="tw-flex tw-gap-3 tw-justify-between tw-h-full">
    <n-card title="Неактивные" size="medium" class="tw-h-full">
      <n-card title="Small Card" size="small" class=""> </n-card>
    </n-card>
    <n-card title="Активные" size="medium" class="tw-h-full"> </n-card>
    <n-card title="В работе" size="medium" class="tw-h-full"> </n-card>
    <n-card title="Готово" size="medium" class="tw-h-full"> </n-card>
  </div>
</template>

<script setup>
import CardTaskVue from "../../components/dashboard/CardTask.vue";
</script>

<style lang="scss" scoped>

</style>