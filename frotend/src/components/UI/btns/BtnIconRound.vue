<template lang="">
    <n-tooltip  placement="left" trigger="hover">
              
        <template #trigger>
            <span @click="action">
                <q-icon :name="icon" />
            </span>
        </template>
        <slot/>
    </n-tooltip>
   
</template>
<script>
export default {
  name: "btn-icon-round",
  props: {
    icon: String,
    description: String,
    action: Function
  },
};
</script>
<style scoped lang="scss">
span {
 cursor: pointer;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.15);
  position: relative;
  padding: 10px;
  background: white;
  border-radius: 1000px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 30px;
}
</style>