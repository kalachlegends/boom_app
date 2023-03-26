<template lang="">
   
    <n-select
    v-model:value="selectedValue"
    filterable
    placeholder="Поиск города"
    :on-search="onSearch"
    :options="options"
    :loading="isLoad"
   :multiple="props.multiple"
    :size="'large'"
  />
</template>
<script setup>
import { axios } from "src/boot/axios";
import { computed, ref, watch } from "vue";
const props = defineProps({
  selectedValue: [String, Array],
  multiple: {
    type: Boolean,
    default: false,
  },
});
const emits = defineEmits("update:selectedValue");
const searchValue = ref("");
const selectedValue = ref(null);

const locations = ref([]);
const onSearch = (value) => {
  searchValue.value = value;
};
const options = computed(() =>
  locations.value.map((e) => {
    return {
      label: e.full_name,
      value: e.id,
    };
  })
);
const isLoad = ref(false);
watch(selectedValue, (newValue) => {
  console.log(`[value="${newValue[0]}"]`)
  console.log(document.querySelector(`[value="${newValue[0]}"]`))
  emits("update:selectedValue", newValue);
});
watch(searchValue, async (newValue) => {
  isLoad.value = true;
  const { data } = await axios.get("/location", {
    params: {
      sample: newValue,
    },
  });
  locations.value = data.locations;
  isLoad.value = false;
});
</script>
<style lang="">
</style>