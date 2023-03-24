<template lang="">
    <textarea v-model="value" @input="handleChange">
        
    </textarea>
</template>
<script>
export default {
  name: "textarea-auto-size",
};
</script>
<script setup>
import { ref, defineProps, defineEmits, onMounted } from "vue";
const props = defineProps({
  value: String,
});

const emits = defineEmits(["value:update"]);
const handleChange = (e) => emits("value:update", value.value);

onMounted(() => {});
</script>
<style scoped lang="scss">
textarea {
  background: none;
  width: 100%;
  resize: none;
  height: 100%;
}
</style>