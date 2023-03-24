<template lang="">

  <NavLanding >

   <router-view />

</NavLanding>

</template>
<script>
import NavLanding from "src/components/nav/NavLanding.vue";
import { ref } from "vue";
export default {
  components: {
    NavLanding,
  },
  setup() {
    // const theme = {
    //   common: {
    //     primaryColor: "rgba(35, 35, 35, 1)",
    //     primaryColorHover: "rgba(59, 58, 58, 1)",
    //   },
    // };
    return {
      // theme,
    };
  },
};
</script>
<style lang="">
</style>