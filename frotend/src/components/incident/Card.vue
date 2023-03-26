<template lang="">
    <n-card :title="props.objectCard.title" :data-type="props.objectCard.status">
        {{props.objectCard.description}}
    </n-card>
</template>
<script setup>
const props = defineProps({
  objectCard: Object,
});
</script>
<style lang="scss">
.n-card[data-type="passive"] {
  background-color: rgb(199, 199, 199);
}
.n-card[data-type="active"] {
  background-color: rgb(247, 153, 153);
}
.n-card[data-type="active"] {
  background-color: rgb(255, 71, 71);
}
</style>