<template lang="">
    <span class="burger" :class="{'active': active}">
        <span></span>
    </span>
</template>
<script>
export default {
  props: {
    active: Boolean,
  },
};
</script>
<style scoped lang="scss">
.burger {
  display: block;
  position: relative;
  width: 30px;
  height: 20px;

  span {
    position: absolute;
    background-color: white;
    left: 0;
    width: 100%;
    height: 2px;
    top: 9px;
    transition: all 0.3s ease 0s;
  }

  &:before,
  &:after {
    content: "";
    position: absolute;
    background-color: white;
    width: 100%;
    height: 2px;
    left: 0;
    transition: all 0.3s ease 0s;
  }

  &:before {
    top: 0;
  }

  &:after {
    bottom: 0;
  }

  &.active span {
    transform: scale(0);
  }

  &.active:before {
    transform: rotate(-45deg);
    top: 9px;
  }

  &.active:after {
    transform: rotate(45deg);
    bottom: 9px;
  }
}
</style>