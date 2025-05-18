<template>
  <div class="waterfall-container">
    <div class="waterfall-column left-column">
      <PostItem 
        v-for="post in leftColumnPosts" 
        :key="post.id" 
        :post="post" 
      />
    </div>
    <div class="waterfall-column right-column">
      <PostItem 
        v-for="post in rightColumnPosts" 
        :key="post.id" 
        :post="post" 
      />
    </div>
  </div>
</template>

<script setup>
import { computed, watch } from 'vue'
import PostItem from './PostItem.vue'

const props = defineProps({
  posts: {
    type: Array,
    default: () => []
  }
})

// 将帖子分配到左右两列，根据奇偶数分配
const leftColumnPosts = computed(() => {
  return props.posts.filter((_, index) => index % 2 === 0)
})

const rightColumnPosts = computed(() => {
  return props.posts.filter((_, index) => index % 2 === 1)
})
</script>

<style scoped>
.waterfall-container {
  display: flex;
  justify-content: space-between;
  width: 100%;
  padding: 10px;
  box-sizing: border-box;
  margin-top: 5px;
}

.waterfall-column {
  width: calc(50% - 5px);
  display: flex;
  flex-direction: column;
}

.left-column {
  margin-right: 5px;
}

.right-column {
  margin-left: 5px;
}
</style> 