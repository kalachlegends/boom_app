<template lang="">
    <n-card :title="props.objectCard.title" hoverable :data-type="props.objectCard.status">
        {{props.objectCard.description}}
        <Like />
    </n-card>
</template>
<script setup>
import { ThumbsUp } from "@vicons/ionicons5";
import Like from "src/components/like/Like.vue";
const props = defineProps({
  objectCard: Object,
});
</script>
<style scoped lang="scss">
svg {
  width: 20px;
}
.n-card {
  -webkit-user-select: none; /* Safari */
  -ms-user-select: none; /* IE 10 and IE 11 */
  user-select: none;
}
.n-card[data-type="passive"] {
  background-color: rgb(199, 199, 199);
}
.n-card[data-type="active"] {
  background-color: rgb(247, 153, 153);
}
.n-card[data-type="completed"] {
  background-color: rgb(65, 129, 5);
}
</style>