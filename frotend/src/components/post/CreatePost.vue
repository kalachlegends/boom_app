<template>
  <n-spin :show="isLoad"> </n-spin>
</template>
  <script setup>
import { axios } from "src/boot/axios.js";
import {
  requiredRules,
  validateNumber,
  requiredRulesAndValidator,
} from "@/helper/defaultRules.js";
import { getOneError } from "@/helper/getOneError.js";
import { useMessage } from "naive-ui";
import { ref } from "vue";
import { useCounterStore } from "src/store/example-store";
const message = useMessage();
const isLoad = ref(false);
</script>
  
  