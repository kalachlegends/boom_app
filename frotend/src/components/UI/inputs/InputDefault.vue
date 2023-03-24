<template lang="">
  <div class="input-block">
    <div class="label" v-if="label != ''" >{{label}}</div>
    <input v-if="type == 'input'" class="input-default" v-bind="inputProps" v-bind:value="value" :class="{ 'danger':  error != '' && error != undefined}" @input="change" >
    <textarea v-else-if="type == 'textarea'" class="input-default" v-bind="inputProps" v-bind:value="value" :class="{ 'danger': error != '' && error != undefined}" @input="change" ></textarea>
    <p class="error " v-if="error != ''  && error != undefined"> {{error}} </p>
  </div>
</template>
<script>
export default {
  name: "input-default",
  model: {
    prop: "value",
    event: "change",
  },
  props: {
    error: String,
    value: String,
    danger: Boolean,
    label: {
      type: String,
      default: "",
    },
    type: {
      type: String,
      default: "input",
    },
    inputProps: Object,
  },
  methods: {
    change(e) {
      this.$emit("inputChange", e);
      this.$emit("update:value", e.target.value);
    },
  },
};
</script>
<style scoped lang="scss" >
@import "src/css/mixins/adaptive-font.scss";
@import "src/css/mixins/rem.scss";
@import "src/css/colors.scss";
.error {
  color: red;
}
.input-default {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: rem(10) rem(25);
  background: #2c2c2c;
  box-shadow: $box-shadow-default;
  border-radius: 7px;
  color: white;

  &.danger {
    color: $text-shadow-danger;
    box-shadow: $box-shadow-danger;
    &:hover {
      color: $text-shadow-danger;
      box-shadow: $box-shadow-danger;
    }
  }
  transition: all 0.3s;
  &.danger {
    color: $text-shadow-danger;
    box-shadow: $box-shadow-danger;
  }
  &:focus {
    box-shadow: 0px 9px 20px rgba(37, 37, 37, 0.25);
    background: #000000;
    //  transform: translateY(-3px);
  }
  @include adaptiv-font(15, 14);
}
</style>