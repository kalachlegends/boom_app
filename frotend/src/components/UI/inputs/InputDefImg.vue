<template lang="">
    <div class="input-image">
        <input-default v-bind:inputProps="inputProps" />
        <q-icon :name="icon" />
    </div>
</template>
<script>
export default {
  name: "input-def-img",
  props: {
    urlImage: String,
    inputProps: Object,
    icon: String,
  },
};
</script>
<style scoped lang="scss">
.input-image {
  position: relative;
  i {
    color: white;

    font-size: 19px;
    position: absolute;
    top: 20%;
    right: 16px;
  }
}
</style>