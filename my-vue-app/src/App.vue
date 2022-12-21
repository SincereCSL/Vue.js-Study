<template>
  <router-view />
</template>
<script setup lang="ts">

import { ref } from "vue";
import HelloWorld from '@/components/HelloWorld.vue'

const hw = ref(null)

const onMyClick = () =>{
    console.log('输出信息')
    // hw.value.someMethod()
}
</script>
<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
