<template lang="">
    <div class="main-clean">
        <div class="login-block">
    
    
          <LogoForAuth />    
                <form class="login-block__body">
        
                  <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
                  <input-image v-model="formData.password" type="password"  :placeholder="'Password'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />

                  <input-image v-model="formData.repassword" type="password" :placeholder="'Repeat password'" urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'repassword')" />
                  <!-- <input-image v-model="dataForm.login"  :placeholder="'Login'" urlImage="img/icons/user.svg" :error="getKeyError(errors.errors, 'login')" /> -->
                  <!-- <input-image v-model="dataForm.password" type="password" :placeholder="'Password'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />
                  <input-image v-model="dataForm.repassword"  type="password"  :placeholder="'Repeat password'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'repassword')" /> -->
               
                    <button @click.prevent="handleClickRestore" type="submit" class="btn-grey">
                        Войти
                    </button>
                  
                </form>
            </div> 
    </div>
    </template>

<script setup>
import LogoForAuth from "src/components/other/LogoForAuth.vue";
import { useRePasswordForEmail } from "src/hooks/auth/useRePasswordForEmail";
const [errors, validate, getKeyError, formData, handleClickRestore, isLoad] =
  useRePasswordForEmail();
</script>

    <style lang="scss" scoped>
@import "src/css/mixins/mixins.scss";
</style>