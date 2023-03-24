<template lang="">
{{user.login}}
{{user.id}}

</template>
<script>
import { useGetProfile } from "src/hooks/user/useGetProfile";
export default {
  setup() {
    const { user } = useGetProfile();

    return {
      user,
    };
  },
};
</script>
<style lang="">
</style>