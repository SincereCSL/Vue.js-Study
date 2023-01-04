<template>
  <div class="common-layout">
    <el-container>
      <el-aside width="200px">
        <Menu />
      </el-aside>
      <el-container>
        <el-header>Header</el-header>
        <el-main>Main</el-main>
        <el-footer>Footer</el-footer>
      </el-container>
    </el-container>
  </div>
</template>
<script setup lang="ts">
import  {Menu} from '@/components/menu.vue'
import {useStore} from "@/store";
const store = useStore();
</script>
<style lang="scss" scoped>

</style>
