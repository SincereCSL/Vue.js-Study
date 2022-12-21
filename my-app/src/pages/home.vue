
<template>
    <h1>这是首页</h1>
    <Todolist/>
    <rate :value="score"></rate>
    <rate :value="3" ></rate>
    <rate :value="4" theme="red"></rate>
    <rate :value="1" theme="green"></rate>
</template>
<script setup>
    import {ref} from 'vue'
    import Todolist from '../components/Todolist.vue'
    import rate from '../components/rate.vue'
    let score = ref(3)
</script>
