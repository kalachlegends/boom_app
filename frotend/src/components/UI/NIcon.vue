<template lang="">
<div>
    <svg v-if="icon == 'tick'"  viewBox="0 0 18 14"  xmlns="http://www.w3.org/2000/svg">
        <path d="M18 2.00003L6 14L0.5 8.50003L1.91 7.09003L6 11.17L16.59 0.590027L18 2.00003Z" />
    </svg> 
    <svg v-if="icon == 'cross'"   viewBox="0 0 16 16"  xmlns="http://www.w3.org/2000/svg">
        <path d="M14.36 15.78L7.99997 9.40997L1.63997 15.78L0.219971 14.36L6.58997 7.99997L0.219971 1.63997L1.63997 0.219971L7.99997 6.58997L14.36 0.229971L15.77 1.63997L9.40997 7.99997L15.77 14.36L14.36 15.78Z"/>
    </svg>
</div>
</template>
<script>
export default {
  name: "n-icon",
  props: {
    icon: String,
  },
};
</script>
<style lang="">
</style>