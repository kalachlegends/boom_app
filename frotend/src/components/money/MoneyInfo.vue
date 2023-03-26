<template>
  <div class="tw-flex tw-justify-between tw-items-center tw-pb-4">
    <!-- <div class="tw-text-lg">{{ name }}</div> -->
    <n-h1 class="sum">Сумма денег: {{ sum }}</n-h1>
  </div>
</template>

<script setup>
import { axios } from "src/boot/axios.js";
import { ref, onMounted } from "vue";

const sum = ref(0);
const org = JSON.parse(localStorage.getItem("org"));
onMounted(async () => {
  await axios
    .get("/money/attrs", {
      params: {
        org_id: org.id,
      },
    })
    .then(({ data }) => {
      console.log(data);
      sum.value = data.money.cash.bills + "." + data.money.cash.coins;
    })
    .catch((error) => {
      console.log(error);
    });
});
</script>

<style lang="scss" scoped>
</style>
