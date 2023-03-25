<template>
  <div class="tw-flex tw-justify-between tw-items-center">
    <div>{{ name }}</div>
    <div class="sum">{{ sum }}</div>
  </div>
</template>

<script>
import { axios } from "src/boot/axios.js";

export default {
  data() {
    return {
      sum: 0,
    };
  },
  mounted() {
    axios
      .get("/money/all")
      .then((response) => {
        console.log(response);
        const name = response.data.money;
        const money = response.data.money[0];
        this.name = name.cash.bills;
        this.sum = money.cash.bills + "." + money.cash.coins;
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>

<style lang="scss" scoped>
/* Стили компонента */
</style>
