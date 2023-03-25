<template>
    <n-spin :show="isLoad">
        <n-form ref="formRef" :label-width="80" :model="formState" :rules="rules" :size="'medium'" class="d-f">

            <n-form-item label="Заголовок" path="title">
                <n-input autosize style="min-width: 30%" v-model:value="formState.title"
                    placeholder="Что случилось? (Кратко)" />
            </n-form-item>

            <n-form-item label="Адрес (Улица, дом)" path="location_address">
                <n-input autosize style="min-width: 30%" v-model:value="formState.location_address"
                    placeholder="Напишите адрес инцидента сюда..." />
            </n-form-item>

            <n-form-item label="Описание" path="description">
                <n-input v-model:value="formState.description" type="textarea" 
                style="width: 60%"
                :autosize="{
                    minRows: 3,
                    maxRows: 7
                }" placeholder="Объясните этот инцидент в больших деталях тут..." />
            </n-form-item>

            <!-- <n-form-item label="Приоритет" path="priority">
                <n-select v-model:value="formState.priority" placeholder="Приоритет" :options="selectPriority" />
            </n-form-item>

            <n-form-item label="Статус инцидента" path="status">
                <n-select v-model:value="formState.status" placeholder="Статус инцидента" :options="selectStatus" />
            </n-form-item> -->

            <!-- <n-form-item label="Примерная дата окончания" path="close_dateq">
                <n-date-picker type="datetime" v-model:value="formState.close_dateq" />
            </n-form-item> -->

            <!-- <n-form-item label="location_id" path="location_id">
                <n-input v-model:value="formState.location_id" placeholder="dev" />
            </n-form-item>

            <n-form-item label="org_id" path="org_id">
                <n-input v-model:value="formState.org_id" placeholder="dev" />
            </n-form-item>

            <n-form-item label="user_id" path="user_id">
                <n-input v-model:value="formState.user_id" placeholder="dev" />
            </n-form-item> -->

            <n-button @click="handleValidateClick">
                Create incident
            </n-button>
        </n-form>
    </n-spin>
</template>
<script setup>
import { axios } from "src/boot/axios.js"
import {
    requiredRules,
    validateNumber,
    requiredRulesAndValidator,
} from "@/helper/defaultRules.js"
import { getOneError } from "@/helper/getOneError.js"
import { useMessage } from "naive-ui"
import { ref } from "vue"
import { datetime } from "@intlify/core-base"
const message = useMessage()
const isLoad = ref(false)
const formRef = ref(null)
const formState = ref({ "close_dateq": new Date().setDate(new Date().getDate() + 2), "description": "", "location_address": "", "location_id": "56461", "org_id": "2def7f07-4676-42cd-b995-39d16854eb73", "title": ""});
const rules = {
    description: requiredRules(),
    title: requiredRules(),
    location_address: requiredRules()
}

const selectPriority = [
    {
        label: "Низкий",
        value: "low"
    },
    {
        label: "Средний",
        value: "medium"
    },
    {
        label: "Высокий",
        value: "high"
    }
]


const selectStatus = [
    {
        label: "Не активен",
        value: "passive"
    },
    {
        label: "Активен",
        value: "active"
    },
    {
        label: "Удалён",
        value: "deleted"
    },
    {
        label: "Завершён",
        value: "completed"
    }
]


const handleValidateClick = (e) => {
    e.preventDefault();
    formRef.value?.validate(async (errors) => {
        console.log(errors);
        if (!errors) {
            isLoad.value = true;
            await axios
                .post("/incident", formState.value)
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
    
    