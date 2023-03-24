<template lang="">
    <div class="input-point">
        <div class="input-point__block"> 
            <input type="number" placeholder="Point" v-bind:value="value" @input="(e) => $emit('update:value', e.target.value)" />
            <img src="~assets/img/icons/star.svg"/>
        </div>
        <div class="input-point__block">
            <span>{{title}}</span>
            <img src="~assets/img/icons/tree.svg"/>
        </div>
    </div>
</template>
<script>
export default {
  name: "input-point",
  props: {
    value: String,
    title: String,
  },
};
</script>
<style scoped lang="scss">
.input-point {
  background: #2c2c2c;
  border-radius: 7px;
  padding: 10px 10px;
  display: flex;
  img {
    width: 18px;
    height: 18px;
  }
  span {
    color: white;
    font-weight: 300;
    font-size: 15px;
  }
  gap: 10px;
  input {
    padding: 5px;
    background: #ffffff;
    box-shadow: 0px 0px 11px rgba(0, 0, 0, 0.25);
    border-radius: 7px;
    color: #2b2929;
    &::placeholder {
      color: #777777;
    }
  }
  flex-direction: column;
  &__block {
    align-items: center;
    justify-content: space-between;
    gap: 5px;

    display: flex;
    gap: 10px;
  }
}
</style>