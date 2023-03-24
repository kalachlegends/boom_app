<template lang="">
    <span v-if="type == 'default' && src != null" class="img " :style="parseStyle(Object.assign({},sx, {width ,height, paddingBottom: padBottom}))">
        <img  :src="src" class="" :alt="alt"  >
        <slot/>
    </span>
    <span v-else-if="src == null" class="img " :style="parseStyle(Object.assign({},sx, {width ,height, paddingBottom: padBottom}))">
      <img  :src="'~assets/img/other/404-not-found.svg'" class="" :alt="'Not found image'"  >
      <slot/>
  </span>
    <span v-else-if="type == 'editor'" class="img-editor" :style="parseStyle(Object.assign({},sx, {width ,height,paddingBottom: padBottom}))">
      <img :src="src" :alt="alt"  >
  </span>
</template>
<script>
import parseObjectToStyle from "src/helper/parseObjectToStyle";
export default {
  name: "img-fluid",
  props: {
    src: {
      type: String,
      default: "~assets/img/other/404-not-found.svg",
    },
    sx: Object,
    width: {
      type: String,
      default: "100%",
    },
    height: {
      type: String,
      default: "100%",
    },
    padBottom: {
      type: String,
      default: "100%",
    },
    alt: String,

    type: {
      type: String,
      default: "default",
    },
  },
  setup(props) {
    return {
      parseStyle: parseObjectToStyle,
    };
  },
};
</script>
<style scoped lang="scss">
.img {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  position: relative;
  padding: 0px 0px 100% 0px;
  img {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    border-radius: 0px;
    object-fit: cover;
  }
}
.img-editor {
  display: block;
  width: 100%;
  img {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    border-radius: 0px;
    object-fit: cover;
  }
}
</style>