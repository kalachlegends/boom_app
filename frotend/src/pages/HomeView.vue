<template>
  <n-h1>Главная</n-h1>
  <CreatePost />
</template>
<script setup>
import CreatePost from "src/components/post/CreatePost.vue";
import { useMetaApp } from "src/hooks/other/useMetaApp";
import { ref, onMounted } from "vue";
import anime from "animejs";
const h1 = ref();

onMounted(() => {
  anime({
    targets: ".animes",
    translateY: [0, 40],
    opacity: [0, 1],
    easing: "linear",
    duration: 1000,
    easing: "easeInOutExpo",
    delay: (el, i) => 100 * i,
  });
});
useMetaApp();
</script>
<script>
import { Notify } from "quasar";
</script>
<style lang="scss" scoped>
@import "src/css/mixins/mixins.scss";
#section-novella {
  height: 100;
  gap: rem(50);
  padding: rem(20) 0;
  @media (max-width: 768px) {
    gap: rem(30);
  }
}

.buttons {
  align-items: center;
  justify-content: center;
  display: flex;
  justify-content: center;
  gap: 15px;
  @media (max-width: 1080px) {
    flex-direction: column;
  }
}

.animes {
  position: relative;
  top: -40px;
}
</style>