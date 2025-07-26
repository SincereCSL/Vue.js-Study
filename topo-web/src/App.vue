<script setup lang="ts">
import TopologyGraph from './components/TopologyGraph.vue'
</script>

<template>
  <div id="app">
    <!-- <h1>网络拓扑图</h1> -->
    <TopologyGraph />
  </div>
</template>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

h1 {
  margin-bottom: 20px;
  color: #ffffff;
}
</style>
