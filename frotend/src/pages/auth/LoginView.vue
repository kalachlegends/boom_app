<template lang="">
<div class="main-clean">
    <div class="login-block">


        <LogoForAuth />
            <form class="login-block__body">
    
              <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
              <input-image v-model="formData.login"  :placeholder="'Имя пользователя'" urlImage="img/icons/user.svg" :error="getKeyError(errors.errors, 'login')" />
              <input-image type="password" v-model="formData.password" :placeholder="'Пароль'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />
                <button @click.prevent="handleClickAuth" type="submit" class="btn-grey">
                    Войти
                </button>
                <div class="df-aic-jc-fx-c gap-10">
                  <router-link to="/register" class="text-align-center "> У вас нет аккаунта? Зарегистрируйтесь </router-link>
                  <router-link to="/restore_password" class="text-align-center width-80">Забыли пароль?</router-link>
                </div>
            </form>
        </div> 
</div>
</template>

<script>
import { ref } from "vue";
import LogoForAuth from "src/components/other/LogoForAuth.vue";

import { useLogin } from "src/hooks/auth/useLogin";
export default {
  components: { LogoForAuth },
  setup() {
    const { formData, getKeyError, errors, handleClickAuth, isLoad } =
      useLogin();

    return {
      formData,
      handleClickAuth,
      isLoad,
      getKeyError,
      errors,
    };
  },
};
</script>

<style lang="scss" scoped >
@import "src/css/mixins/mixins.scss";
.main-clean {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #2c2c2c;
}
</style>