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
      <n-form-item label="Денньги" path="cash">
        <n-input-number
          v-model:value="formState.cash.bills"
          :default-value="1075"
          placeholder="сколько денег"
        />
      </n-form-item>

      <n-form-item label="Тип операции" path="movement">
        <n-select
          v-model:value="formState.movement"
          :default-value="1075"
          :options="optoinsMovement"
        />
      </n-form-item>

      <n-form-item label="Тип работы" path="type">
        <n-select v-model:value="formState.type" :options="options" />
      </n-form-item>

      <n-button @click="handleValidateClick">
        Внесение и Изъятие денег
      </n-button>
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
const org = JSON.parse(localStorage.getItem("org"));
const optoinsMovement = [
  {
    label: "Вычитание",
    value: 0,
  },
  {
    label: "Внесение",
    value: 1,
  },
];
const options = [
  {
    label: "Капитальный ремонт",
    value: "Капитальный ремонт",
  },
  {
    label: "Сантехника",
    value: "Сантехника",
  },
  {
    label: "Уборка",
    value: "Уборка",
  },
  {
    label: "Электрика",
    value: "song4",
  },
  {
    label: "Двор",
    value: "Двор",
  },
  {
    label: "Маляреные работы",
    value: "Маляреные работы",
  },
  {
    label: "Обеспечение обезапности",
    value: "Обеспечение обезапности",
    disabled: true,
  },
];
const formState = ref({
  attrs: {},
  cash: {
    bills: 0,
  },
  movement: 0,
  org_id: org.id,
  type: "Капитальный ремонт",
});
const rules = {};
const handleValidateClick = (e) => {
  e.preventDefault();
  formRef.value?.validate(async (errors) => {
    console.log(errors);
    if (!errors) {
      isLoad.value = true;
      await axios
        .post("/money", formState.value)
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
  
  