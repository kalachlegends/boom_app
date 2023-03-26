<template lang="">
    <div class="tw-flex tw-justify-between">
        <span class="tw-flex tw-justify-between tw-items-center tw-gap-2">
            <ThumbsUp class=" tw-rotate-180"/>
            <span>{{props.disLike}} </span>
        </span>
        
  

        <span class="tw-flex tw-justify-between tw-items-center  tw-gap-2">
            <ThumbsUp class=""/>
        <span>{{props.like}} </span>
        </span>
    </div>
     
</template>
<script setup>
import { ThumbsUp } from "@vicons/ionicons5";
const props = defineProps({
  like: {
    type: String,
    default: 0,
  },
  disLike: {
    type: String,
    default: 0,
  },
});
</script>
<style lang="scss" scoped>
svg {
  width: 20px;
}
</style>