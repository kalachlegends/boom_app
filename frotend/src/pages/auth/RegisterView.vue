<template lang="">
    <div class="main-clean">
        <div class="login-block">
    
          <LogoForAuth />    
        
                 <form class="login-block__body">
                  <n-h1>Выберите город для начало</n-h1>
                  <SearchLocation v-model:selectedValue="selectedValue" multiple="true"/>
                  <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
                 <!-- <input-image v-model="dataForm.email" :placeholder="'Email'"  urlImage="img/icons/baseline-email.svg" :error="getKeyError(errors.errors, 'email')" />
                  <input-image v-model="dataForm.login"  :placeholder="'Имя пользователя'" urlImage="img/icons/user.svg" :error="getKeyError(errors.errors, 'login')" />
                  <input-image v-model="dataForm.password" type="password" :placeholder="'Пароль'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />
                  <input-image v-model="dataForm.repassword"  type="password"  :placeholder="'Повторите пароль'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'repassword')" />
               
                    <button @click.prevent="handleClickRegister" type="submit" class="btn-grey">
                        Войти
                    </button>
                    <div class="df-aic-jc-fx-c gap-10">
                        <router-link to="/login" class="text-align-center width-80">У вас уже есть аккаунт? Можете войти здесь</router-link>
                        <router-link to="/restore_password" class="text-align-center width-80">Забыли пароль?</router-link>
                    </div> -->
                </form>  
                <span class="tw-flex tw-justify-between tw-gap-10">
                  {{selectedValue}}
                  <ArrowBack />
                  <span class="steps">
                    {{steps}} / {{limit}}
                  </span>
                  <ArrowBack @click="handleStep('next')" class="tw-rotate-180" />
                </span>
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
    const limit = 3;
    const selectedValue = ref(null);
    const handleStep = (type) => {
      if (limit > steps.value) {
        console.log("asd");
        steps.value = steps.value + 1;
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
      selectedValue,
    };
  },
};
</script>
    <style lang="scss" scoped>
@import "src/css/mixins/mixins.scss";
.n-h1 {
  color: white;
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
</style>