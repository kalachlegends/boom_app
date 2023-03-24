<template lang="">

    <div class="drop-down default" ref="title"> 
        <div class="drop-down__title df-aic"  @click="openDropDown">
          {{ title }}
            <span class="df-aic-jcc ml-16" >
                <img src="src/assets/img/icons/arrow.svg" alt="">
            </span>
        </div>
  
        <div class="drop-down__children children"  v-if="isOpen">
          <div class="drop-down__item-child" v-for="children in childrens"  @click="selectet(children)" >

            {{ children.key }}
          </div>
        </div>

     </div>


</template>
<script>
export default {
  name: "DropDownDefault",
  props: {
    modelValue: String,
    childrens: Array,
  },
  data() {
    return {
      isOpen: false,
      title: "",
    };
  },
  methods: {
    openDropDown() {
      if (this.isOpen) this.isOpen = false;
      else this.isOpen = true;
    },
    selectet(children) {
      this.openDropDown();
      this.title = children.key;
      this.$emit("update:modelValue", children.value);
      this.$emit("select", children.value);
    },
  },
  mounted() {
    const title =
      this.childrens.find((e) => e.value == this.modelValue) ||
      this.childrens[0];

    this.title = title["key"];
    const thisMounted = this;
    window.addEventListener("click", function (e) {
      const withinBoundaries = e
        .composedPath()
        .includes(thisMounted.$refs.title);
      if (!withinBoundaries) {
        thisMounted.isOpen = false;
      }
    });
  },
};
</script>
<style scoped lang="scss">
@import "src/css/colors.scss";
.default {
  background: #2c2c2c;
  color: white;
  padding: 10px 15px;
  border-radius: 7px;
  .drop-down__title {
    width: 100%;
    justify-content: space-between;
  }
}
.children {
  width: 100%;
  top: 38px;
  left: 0;
}
</style>