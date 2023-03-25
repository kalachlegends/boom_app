<template lang="">
    <div class="main-clean">
        <div class="login-block">
    
    
            <LogoForAuth />    
                <form class="login-block__body">
        
                  <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
                  <input-image v-model="formData.email" :placeholder="'Email'"  urlImage="img/icons/baseline-email.svg" :error="getKeyError(errors.errors, 'email')" />
                  <!-- <input-image v-model="dataForm.login"  :placeholder="'Login'" urlImage="img/icons/user.svg" :error="getKeyError(errors.errors, 'login')" /> -->
                  <!-- <input-image v-model="dataForm.password" type="password" :placeholder="'Password'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />
                  <input-image v-model="dataForm.repassword"  type="password"  :placeholder="'Repeat password'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'repassword')" /> -->
               
                    <button @click.prevent="handleClickRestore" type="submit" class="btn-grey">
                        Войти
                    </button>
                    <div class="df-aic-jc-fx-c gap-10">
                        <router-link to="/login" class="text-align-center width-80">У вас уже есть аккаунт? Можете войти здесь</router-link>
                    </div>
                </form>
            </div> 
    </div>
    </template>

<script setup>
import LogoForAuth from "src/components/other/LogoForAuth.vue";
import { useRepassword } from "src/hooks/auth/useRepassword";
const [errors, validate, getKeyError, formData, handleClickRestore, isLoad] =
  useRepassword();
</script>

    <style lang="scss" scoped>
@import "src/css/mixins/mixins.scss";
</style>