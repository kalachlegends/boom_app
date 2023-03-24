<template lang="">
<div class="right-menu">
    <div class="right-menu__body">
        <slot>
            
        </slot>
    </div>
    <div class="right-menu__body">
        <btn-editor @click=" () =>$emit('prev')">
            <img src="src/assets/img/icons/step.svg" alt="">
        </btn-editor>
        
        <btn-editor @click=" () => $emit('next')">
            <img class="rotate-horizontal" src="src/assets/img/icons/step.svg" alt="">
        </btn-editor>
    </div>
</div>


</template>
<script>
export default {
  name: "right-menu",
  methods: {
    next() {},
  },
};
</script>
<style scoped lang="scss">
@import "src/css/colors.scss";

.right-menu {
  user-select: none;
  border: 1px solid $p-grey;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  position: relative;
  z-index: 1001;
  height: 100%;
}

.right-menu__body {
  &:nth-child(1) {
    display: flex;
    flex-direction: column;
  }

  &:nth-child(2) {
    display: flex;

    button {
      width: 100%;
    }
  }
}
</style>