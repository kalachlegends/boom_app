<template>
  <NavLanding />

  <Wrapper>
    <router-view></router-view>
  </Wrapper>
</template>
  
<script>
import Wrapper from "src/components/other/Wrapper.vue";
export default {
  components: {
    Wrapper,
  },
};
</script>