<template>
  <n-config-provider :theme="darkTheme">
    <router-view />
  </n-config-provider>
</template>
<script setup>
import { darkTheme } from "naive-ui";
</script>