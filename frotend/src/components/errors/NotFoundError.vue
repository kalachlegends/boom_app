<template lang="">
    <div class="page">
      <!-- <router-link v-for="item in listGifs" to="/">        
        <img  ref="muha" class="animate" :src="'/static/img/other/' + item"/> 
      </router-link> -->
      <div class="page__body">
        <h1>404 NOT FOUND</h1>
     <router-link to='/'>   <h2>Back to home</h2> </router-link>
        <img-fluid ref="muha"  :src="'/static/img/other/error.png'"/> 
      </div>

    </div>
</template>
<script setup>
import anime from "animejs";
import { onMounted, ref } from "vue";

const muha = ref();
const listGifs = ["colin-raff-grotesque.gif", "colin-raff-grotesque.gif"];
onMounted(() => {
  // muha.value.forEach((element) => {
  //   anime({
  //     targets: element,
  //     keyframes: [
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190) },
  //       { rotate: anime.random(0, 190), translateY: -100 },
  //       { rotate: anime.random(0, 190), translateX: 300 },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateY: anime.random(0, 400) },
  //       { rotate: anime.random(0, 190), translateX: 300 },
  //     ],
  //     duration: 100000,
  //     direction: "alternate",
  //     easing: "cubicBezier(.3, .06, .1, .3)",
  //     loop: true,
  //   });
  // });
});
</script>
<style lang="scss" scoped>
.page {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  &__body {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
  }
  .animate {
    position: absolute;
    width: 32px;
    top: 500px;
  }
}
</style>