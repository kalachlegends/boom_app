<template>
  <MoneyInfoVue />
  <n-button @click="showModal = true">Внесение и Изъятие денег</n-button>
  <MoneyTableVue />
  <n-modal v-model:show="showModal">
    <n-card
      style="width: 600px"
      title="Внесение и Изъятие денег"
      :bordered="false"
      size="huge"
      role="dialog"
      aria-modal="true"
    >
      <MoneyCreate />
    </n-card>
  </n-modal>
</template>

<script setup>
import { ref } from "vue";
import MoneyTableVue from "../../components/money/MoneyTable.vue";
import MoneyInfoVue from "../../components/money/MoneyInfo.vue";
import MoneyCreate from "../../components/money/CreateMoney.vue";
const showModal = ref(false);
</script>

<style lang="scss" scoped>
</style>