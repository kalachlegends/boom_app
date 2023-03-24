<template lang="">
    <div class="input-event">
        <input-default   v-bind:value="value" @input-change="(event) => $emit('update:value', event.target.value)" v-bind:inputProps="{placeholder: 'Event'}" />
            <div class="input-img" @click="treeClick">
                <img src="~assets/img/icons/tree.svg" />
            </div>
       </div>
    
</template>
<script>
export default {
  name: "input-tree",
  model: {
    prop: "value",
    event: "change",
  },
  props: {
    value: String,
    inputAttrs: Object,
    attrs: Array,
  },
  methods: {
    treeClick(event) {
      this.$emit("treeClick", event, this.attrs);
    },
  },
};
</script>
<style  lang="scss">
.input-event {
  position: relative;
  display: flex;
  width: 100%;
  align-items: center;
  .input-block {
    height: 100%;
    padding-right: 35px;
  }
  input {
    height: 100%;
    font-size: 18px;
  }
  .input-img {
    cursor: pointer;
    border-radius: 7px;
    display: flex;
    align-items: center;
    justify-content: center;
    right: 0px;
    padding: 0px 16px;
    position: absolute;
    background: #474747;
    height: 100%;
  }
}
</style>