<template lang="">
    <button class="btn">
       <span>
        <slot class="mr-10">
            
        </slot>
       </span>
     <q-icon :name="icon" />

    </button>
</template>
<script>
export default {
  name: "btn-plus",
  props: {
    icon: {
      default: "add",
      type: String,
    },
  },
};
</script>
<style scoped lang="scss">
@import "src/css/colors.scss";

.btn {
  display: flex;
  align-items: center;
  font-weight: 300;
  padding: 5px;
  font-size: 16px;
  background: none;
  transition: all 0.3s;
  position: relative;
  img {
    transition: all 0.3s;
    transform: rotate(0deg);
  }
  &:hover {
    opacity: 0.9;
    transition: all 0.8s;
    img {
      transition: all 0.3s;
      transform: rotate(90deg);
    }
  }
}
</style>