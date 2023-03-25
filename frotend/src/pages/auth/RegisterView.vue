<template lang="">
    <div class="main-clean">
        <div class="login-block">
    
          <LogoForAuth />    
          <form  class="login-block__body">
            <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
                   <Transition name="nested">
                    <n-form class="outer">
                      <div v-if="steps == 1" class='tw-flex tw-flex-col tw-gap-4'>
                        <n-h1>Выберите город для начало</n-h1>
                        <n-form-item label="Адрес" path="location.locality_id">
                        <SearchLocation v-model:selectedValue="dataForm.location.location_id" />
                        </n-form-item>
                        <n-form-item label="Адрес" path="">
                        <n-input placeholder="Адрес" size="large" v-model="dataForm.location.address" />
                        </n-form-item>
                       </div>
                      <div v-if="steps == 2" class='tw-flex tw-flex-col tw-gap-4'>
                        <n-h1>Регистрация</n-h1>
                        <n-form-item label="ИИН" path="login">
                        <n-input v-model:value="dataForm.login" size="large"  :placeholder="'Авторизация'" urlImage="img/icons/user.svg" />
                        </n-form-item>
                        <n-form-item label="Пароль" path="password">
                          <n-input v-model:value="dataForm.password" size="large" type="password" :placeholder="'Пароль'" urlImage="img/icons/user.svg" />
                          </n-form-item>
                        
                       
                      </div>

                    </n-form>
               
               
                </Transition>  
                    <span class="tw-flex tw-justify-between tw-gap-10">
                      
                      <ArrowBack  @click="handleStep('prev')" />
                      <span class="steps">
                        {{steps}} / {{limit}}
                      </span>
                      <ArrowBack @click="handleStep('next')" class="tw-rotate-180" />
                    </span>
                    <div class="df-aic-jc-fx-c gap-10">
                      <router-link to="/login" class="text-align-center width-80">У вас уже есть аккаунт? Можете войти здесь</router-link>
                      <router-link to="/restore_password" class="text-align-center width-80">Забыли пароль?</router-link>
                  </div> 
                </form>
            </div> 
            
    </div>
    </template>

    <script>
import { ref } from "vue";
import LogoForAuth from "src/components/other/LogoForAuth.vue";
import { useRegister } from "src/hooks/auth/useRegister";
import { ArrowBack } from "@vicons/ionicons5";
import SearchLocation from "src/components/location/SearchLocation.vue";
export default {
  components: { LogoForAuth, SearchLocation, ArrowBack },
  setup() {
    const { dataForm, handleClickRegister, isLoad, getKeyError, errors } =
      useRegister();
    const steps = ref(1);
    const limit = 2;

    const handleStep = async (type) => {
      if (type == "next" && limit > steps.value) {
        steps.value = steps.value + 1;
        return;
      }
      if (limit == steps.value) {
        await handleClickRegister();
        console.log("123");
      }
      if (steps.value != 1 && type == "prev") {
        steps.value = steps.value - 1;
      }
    };
    return {
      dataForm,
      handleClickRegister,
      isLoad,
      getKeyError,
      errors,
      steps,
      limit,
      handleStep,
    };
  },
};
</script>
    <style lang="scss" scoped>
@import "src/css/mixins/mixins.scss";
label {
  color: white;
}
.n-h1 {
  color: white;
}
.nested-enter-active .tw-flex,
.nested-leave-active .tw-flex {
  transition: all 0.3s ease-in-out;
}

.nested-enter-from .tw-flex,
.nested-leave-to .tw-flex {
  transform: translateX(30px);
  opacity: 0;
}

svg {
  color: white;
  width: 34px;
}
.steps {
  font-size: 20px;
  font-weight: bold;
  color: white;
}
.login-block__body {
  gap: 30px;
}
</style>