<template>
    <n-spin :show="isLoad">
        <n-form ref="formRef" :label-width="80" :model="formState" :rules="rules" :size="'medium'" class="d-f">

            <n-form-item label="Лист управляемых локаций" path="locations_list">
                <SearchLocation autosize style="width: 50em" v-model:selected-value="formState.locations_list" multiple="true"  />
            </n-form-item>

            <n-form-item label="Тип организации" path="roles">
                <n-select autosize style="width: 10em" v-model:value="formState.roles" :options="roleOptions" />
            </n-form-item>

            <n-form-item label="Название" path="title">
                <n-input autosize style="min-width: 25%" v-model:value="formState.title" placeholder="Название организации" />
            </n-form-item>

            <n-form-item label="БИН" path="bin">
                <n-input autosize style="min-width: 25%" v-model:value="formState.bin" placeholder="БИН" />
            </n-form-item>

            <n-form-item label="Пароль" path="password">
                <n-input autosize style="min-width: 25%" v-model:value="formState.password" placeholder="Пароль" />
            </n-form-item>

            <n-button @click="handleValidateClick">
                Создать
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
import SearchLocation from "src/components/location/SearchLocation.vue";
import { getOneError } from "@/helper/getOneError.js"
import { useMessage } from "naive-ui"
import { ref } from "vue"
const message = useMessage()
const isLoad = ref(false)
const formRef = ref(null)
const nothing = null
const roleOptions = [
    {
        label: "КСК",
        value: "ksk"
    },
    {
        label: "ОСИ",
        value: "osi"
    }
]
const formState = ref({ "locations_list": [], "title": "", "bin": "", "password": "", "repassword": "", "roles": "" })
const rules = {
    locations_list: requiredRules("Обязательный параметр",{type: "array"}),
    title: requiredRules(),
    bin: requiredRules(),
    password: requiredRules(),
    repassword: requiredRules(),
    roles: requiredRules()
}
const handleValidateClick = (e) => {
    console.log(formState)
    e.preventDefault()
    formRef.value?.validate(async (errors) => {
        console.log(errors)
        if (!errors) {
            isLoad.value = true
            await axios
                .post("/organization", formState.value)
                .then(({ data }) => {
                    console.log(data)
                    message.success("Успешно создано!")
                })
                .catch(({ response }) => {
                    console.log(response)
                    message.error(getOneError(response.data.error))
                });
            isLoad.value = false;
        }
    });
};
</script>
    
    