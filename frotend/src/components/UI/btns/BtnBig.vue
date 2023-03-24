<template lang="">
    <div class="btn-big">
        <span><slot/> </span>
        <q-icon v-if="icon != ''" :name="icon" />
    </div>
</template>
<script>
export default {
  name: "btn-big",
  props: {
    icon: {
      type: String,
      default: "",
    },
  },
};
</script>
<style lang="scss">
@import "src/css/mixins/adaptive-font.scss";

.btn-big {
  padding: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  background: #1d0f0f;
  font-weight: bold;
  color: white;
  @include adaptiv-font(16, 14);
  border-radius: 10px;
}
</style>