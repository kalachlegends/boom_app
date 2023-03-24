<template lang="">
    <div class="block">
        <div class="title" v-if="!isEdit">
           <span>
            {{value}}
           </span>

            <div @click="click(true)" class="circle">
                <img src="src/assets/img/icons/pencil.svg" alt="">
            </div>
        </div>
       
        <div v-if="isEdit" class="d-flex">
            <input v-if="isEdit" class="input-edit input-default" :value="value" @input="(e) => title = e.target.value" v-bind="inputAttrs" />
            <div class="d-flex gap-5">
              <n-icon class="icon green" icon="tick" @click="save"/>
              <n-icon class="icon red" icon="cross"  @click="click(false)"/>
            </div>
           
        </div>
      
       
    </div>
</template>
<script>
export default {
  name: "input-edit",
  model: {
    prop: "value",
    event: "change",
  },
  data() {
    return {
      isEdit: false,
      title: "",
    };
  },
  methods: {
    click(Boolean) {
      this.isEdit = Boolean;
    },
    save() {
      this.isEdit = false;
      this.$emit("update:value", this.title);
    },
  },
  props: {
    value: String,
    inputAttrs: Object,
  },

  mounted() {
    this.title = this.value;
  },
};
</script>
<style scoped lang="scss">
@import "src/css/mixins/mixins.scss";
.title {
  @include adaptiv-font(32, 18);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  .circle {
    position: absolute;
    right: -30px;
    top: -5px;
  }
  gap: 20px;
  input {
    @include adaptiv-font(32, 18);
  }
}
.input-edit {
  margin-right: 10px;
  outline: 1px solid #e8e8e8;
}
.icon {
  width: 28px;
  height: 28px;

  display: flex;
  align-items: center;
  justify-content: center;
  padding: 5px;
  background: #000;
  fill: white;
  border-radius: 100%;
  cursor: pointer;
  &.green {
    transition: 0.3s all;
    background: rgb(153, 226, 43);
    &:hover {
      background: rgb(130, 216, 0);
    }
  }
  &.red {
    transition: 0.3s all;
    background: #ea5d5d;
    &:hover {
      background: #c24444;
    }
  }
}
.block {
  input {
    @include adaptiv-font(24, 18);
  }
}
</style>