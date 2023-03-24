<template lang="">
    <div>
      <div class="input-block icon ">
          <input :type="type" v-model="value" @input="onChangeInput" :placeholder="placeholder" class="input" :class="{ 'shadow-danger': error}">
        <img :src="'/static/' + urlImage" :alt="alt"> 
      </div>
      <p v-if="error" class=" text-danger">{{ error }}</p>
    </div>
    

</template>
<script setup>
</script>
<script>
export default {
  name: "input-image",
  model: {
    prop: "modelValue",
    event: "change",
  },
  props: {
    modelValue: String,
    alt: String,
    placeholder: String,
    type: {
      default: "text",
      type: String,
    },
    urlImage: String,
    error: String,
  },
  methods: {
    onChangeInput(e) {
      this.$emit("update:modelValue", e.target.value);
    },
  },
};
</script>
<style lang="scss" scoped>
.text-danger {
  color: rgb(255, 85, 85);
}
.shadow-danger {
  box-shadow: 0px 1px 16px rgba(255, 0, 0, 0.5);
}
.input-block {
  position: relative;

  &.icon {
    .input {
      padding: 20px 20px 20px 60px;
    }

    img {
      position: absolute;
      top: 32%;
      left: 20px;
    }
  }
}
</style>