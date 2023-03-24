<template lang="">
<loader-full-page>
<n-menu >
<slot > </slot>
  <router-view/>
</n-menu>
</loader-full-page>
</template>
<style lang="scss" >
@import url("src/css/style.scss");
</style>>

<script>
import NMenu from "components/menu/Menu.vue";

export default {
  components: {
    NMenu,
  },
};
</script>
