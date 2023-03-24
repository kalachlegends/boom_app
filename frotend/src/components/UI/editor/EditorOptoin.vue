<template lang="">
    <div class="optoins">
        <div class="optoins__body">
          <div class="optoins__title mb-16">{{title}}</div>
          <slot/>
        </div>
    </div>
</template>
<script>
export default {
  name: "editor-optoin",
  props: {
    title: String,
  },
};
</script>
<style lang="">
</style>