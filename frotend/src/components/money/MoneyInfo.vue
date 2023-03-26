<template>
  <div class="tw-flex tw-justify-between tw-items-center tw-pb-4">
    <!-- <div class="tw-text-lg">{{ name }}</div> -->
    <div class="sum">Сумма денег: {{ sum }}</div>
  </div>
</template>

<script>
import { axios } from "src/boot/axios.js";

export default {
  data() {
    return {
      sum: 0,
      name: "",
    };
  },
  mounted() {
    axios
      .get("/money/all")
      .then((response) => {
        const data = response.data.money[0];
        console.log(data);
        this.sum = data.cash.bills + "." + data.cash.coins;
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>

<style lang="scss" scoped>
</style>
