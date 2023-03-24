<template lang="">
    <div class="btn-outline scale-up-hover">
    <slot/>
    </div>
</template>
<script>
export default {
  name: "btn-outline",
};
</script>
<style lang="scss" >
.btn-outline {
  padding: 4px 15px;
  border: 1px solid #ffffff;
  border-radius: 10px;
}
</style>