<template lang="">
  <Teleport to="body">
    <div ref="context" :style="style" v-if="isContext" class="context-menu">
        <div class="context-menu__item" v-for="item in items"  @click="handleClickItemContext(item)">{{item.name}}</div>
    </div>
  </Teleport>
</template>
<script>
import { h, onMounted, ref } from "vue";

export default {
  name: "context-menu",
  props: {
    items: Array,
    getElements: Function,
  },
  mounted() {
    this.$emit("contex-menu-handle", this.callContext);

    document.addEventListener("click", (e) => {
      const withinBoundaries = e.composedPath().includes(this.$refs.context);
      let outsideWithinBoundaries = true;

      if (this.getElements != undefined) {
        const elements = this.getElements();
        outsideWithinBoundaries = e.composedPath().some((el1) => {
          return elements.some((el) => el1 == el);
        });
      } else {
        outsideWithinBoundaries = false;
      }
      if ((!withinBoundaries, !outsideWithinBoundaries)) {
        this.isContext = false;
      }
    });
  },
  setup(props) {
    const attrs = ref([]);
    //const currentId = ref("");
    const isContext = ref(false);
    const style = ref({});

    const handleClickItemContext = (item) => {
      item.callback(attrs.value, item);
      isContext.value = false;
    };

    const callContext = (event, object) => {
      event.preventDefault();

      attrs.value = object;
      // currentId.value = object.currentId;
      style.value = {
        left: event.pageX + "px",
        top: event.pageY + "px",
        zIndex: 100000000000000000000,
      };

      isContext.value = true;
    };
    return {
      callContext,
      style,
      isContext,
      handleClickItemContext,
    };
  },
};
</script>
<style lang="scss" scoped>
.context-menu {
  position: absolute;
  width: 200px;
  max-height: 200px;
  background: black;
  &__item {
    color: white;
    background: #2c2c2c;
    padding: 10px;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    &:hover {
      background: #0d99ff;
    }
  }
}
</style>