<template>
  <div>{{ rate }}}</div>
</template>

<script setup lang="ts">
import {defaultProps,computed} from "vue";
let props = defaultProps({
    value:Number
})
let rate = computed(()=>"★★★★★☆☆☆☆☆".slice(5-props.value,10-props.vue))
</script>

<style scoped>

</style>
