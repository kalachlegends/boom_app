<template lang="">
    <div class="lds-ellipsis" :[dataTheme]="theme" :style="parseStyle(sx)"><div></div><div></div><div></div><div></div></div>

</template>
<script>
import parseObjectToStyle from "src/helper/parseObjectToStyle";
export default {
  name: "loader",
  props: {
    sx: Object,
    theme: String,
  },
  setup() {
    return {
      parseStyle: parseObjectToStyle,
      dataTheme: "data-theme",
    };
  },
};
</script>
<style  >
:root {
  --color-nav-bg: white;
}
[data-theme="dark"] {
  --color-nav-bg: black;
}

.lds-ellipsis {
  display: inline-block;
  position: relative;
  width: 80px;
  height: 80px;
}
.lds-ellipsis div {
  position: absolute;
  top: 33px;
  width: 13px;
  height: 13px;
  border-radius: 50%;
  background: var(--color-nav-bg);
  animation-timing-function: cubic-bezier(0, 1, 1, 0);
}
.lds-ellipsis div:nth-child(1) {
  left: 8px;
  animation: lds-ellipsis1 0.6s infinite;
}
.lds-ellipsis div:nth-child(2) {
  left: 8px;
  animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(3) {
  left: 32px;
  animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(4) {
  left: 56px;
  animation: lds-ellipsis3 0.6s infinite;
}
@keyframes lds-ellipsis1 {
  0% {
    transform: scale(0);
  }
  100% {
    transform: scale(1);
  }
}
@keyframes lds-ellipsis3 {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(0);
  }
}
@keyframes lds-ellipsis2 {
  0% {
    transform: translate(0, 0);
  }
  100% {
    transform: translate(24px, 0);
  }
}
</style>