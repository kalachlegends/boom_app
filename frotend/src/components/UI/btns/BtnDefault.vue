<template lang="">
    <button class="btn-default " :class="{ 'danger': danger,'active': active}">
        <slot/>
    </button>
</template>
<script>
export default {
  name: "btn-default",
  props: {
    danger: Boolean,
    active: Boolean,
  },
};
</script>
<style scoped lang="scss">
@import "src/css/mixins/adaptive-font.scss";
@import "src/css/mixins/rem.scss";
@import "src/css/colors.scss";

.btn-default {
  &.active {
    color: rgb(255, 255, 255);
    background: #000000;
  }
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px 15px;
  background: #2c2c2c;
  box-shadow: $box-shadow-default;
  border-radius: 7px;
  color: white;
  font-weight: 500;
  text-transform: uppercase;
  transition: all 0.3s;
  &.danger {
    color: $text-shadow-danger;
    box-shadow: $box-shadow-danger;
    &:hover {
      color: $text-shadow-danger;
      box-shadow: $box-shadow-danger;
    }
  }
  &:hover {
    color: rgb(231, 231, 231);
    box-shadow: 0px 0px 15px rgba(15, 15, 15, 0.55);
    background: #222222;
    //  transform: translateY(-3px);
  }
  &:focus {
    color: rgb(255, 255, 255);
    background: #000000;
    //  transform: translateY(-3px);
  }
  @include adaptiv-font(16, 14);
}
</style>