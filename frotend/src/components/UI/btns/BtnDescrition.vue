<template lang="">
    <btn-default class="btn-description">
        
        <span class="title">
            <img v-if="urlImage" :src="'/static/' + urlImage" :alt="alt" />
            <span>{{title}}</span>
         
        </span>
        <span class="description">
            {{description}}
        </span>
    </btn-default>
</template>
<script>
export default {
  name: "btn-desription",
  props: {
    title: String,
    description: String,
    urlImage: String,
  },
};
</script>
<style scoped lang="scss">
.title {
  align-items: center;
  justify-content: center;
  display: flex;
  gap: 10px;
  font-weight: 400;
}
.description {
  font-weight: 200;
}
.btn-description {
  user-select: none;
  img {
    user-select: none;
    width: 24px;
  }
  align-items: center;
  justify-content: center;
  display: flex;
  gap: 10px;
  flex-direction: column;
}
</style>