<template>
  <n-spin :show="isLoad">
    <n-form
      ref="formRef"
      :label-width="80"
      :model="formState"
      :rules="rules"
      :size="'medium'"
      class="d-f"
    >
      <n-form-item label="login" path="login">
        <n-input v-model:value="formState.login" placeholder="login" />
      </n-form-item>

      <n-form-item label="password" path="password">
        <n-input v-model:value="formState.password" placeholder="password" />
      </n-form-item>

      <n-button @click="handleValidateClick"> LOGIN </n-button>
    </n-form>
  </n-spin>
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
const message = useMessage();
const isLoad = ref(false);
const formRef = ref(null);
const formState = ref({ login: "test", password: "1234" });
const rules = {};
const handleValidateClick = (e) => {
  e.preventDefault();
  formRef.value?.validate(async (errors) => {
    console.log(errors);
    if (!errors) {
      isLoad.value = true;
      await axios
        .post("/auth/login", formState.value)
        .then(({ data }) => {
          console.log(data);
          message.success("Успешно создано!");
        })
        .catch(({ response }) => {
          console.log(response);
          message.error(getOneError(response.data.error));
        });
      isLoad.value = false;
    }
  });
};
</script>
  
  