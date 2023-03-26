<template lang="">
    <n-input
    type="textarea"
    placeholder="Написать коментарий"
    v-model:value="commentValue"
    @keyup.enter="handleComment"
  />
  <n-thing content-indented v-for="item in commentList" :description="item.body" >
    <template #header>
      Время - {{item.inserted_at}}
    </template>
    <template #avatar>{{ item.user.data.name || "Анонимус" }}</template>
 
  </n-thing>

</template>
<script setup>
import { axios } from "src/boot/axios";
import { onMounted, ref } from "vue";
const commentList = ref([]);
const commentValue = ref("");
const props = defineProps({
  parent_id: String,
});
const handleComment = async () => {
  await axios
    .post("/comments", {
      body: commentValue.value,
      parent_id: props.parent_id,
    })
    .then(({ data }) => {
      console.log(data);
      commentValue.value = "";
      commentList.value = [...commentList.value, data.comments];
    });
};
onMounted(async () => {
  await axios
    .get("/comments/all", {
      params: {
        parent_id: props.parent_id,
      },
    })
    .then(({ data }) => {
      console.log(data);
      commentList.value = data.comments;
    });
});
</script>
<style lang="">
</style>