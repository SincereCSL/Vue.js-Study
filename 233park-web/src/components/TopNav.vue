<template>
  <div class="top-nav">
    <div class="nav-tabs">
      <div 
        v-for="(tab, index) in tabs" 
        :key="index" 
        class="tab-item"
        :class="{ active: currentTab === tab.value }"
        @click="changeTab(tab.value)"
      >
        {{ tab.name }}
      </div>
    </div>
    <div class="right-icons">
      <van-icon name="search" size="20" />
      <van-icon name="chat-o" size="20" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  currentTab: {
    type: String,
    default: 'recommend'
  }
})

const emit = defineEmits(['update:currentTab'])

const tabs = [
  { 
    name: '发现', 
    value: 'recommend'
  },
  { 
    name: '游戏圈', 
    value: 'game'
  },
  { 
    name: '新玩意', 
    value: 'new'
  }
]

const changeTab = (tab) => {
  emit('update:currentTab', tab)
}
</script>

<style scoped>
.top-nav {
  position: sticky;
  top: 0;
  z-index: 100;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0;
  height: 44px;
  background-color: #fff;
  border-bottom: 1px solid #f0f0f0;
}

.nav-tabs {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 65%;
  height: 100%;
  margin: 0 auto;
}

.tab-item {
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  height: 100%;
  padding: 0 8px;
  font-size: 14px;
  font-weight: bold;
  color: #666;
  white-space: nowrap;
}

.tab-item.active {
  color: #333;
}

.tab-item.active::after {
  content: '';
  position: absolute;
  bottom: 4px;
  left: 50%;
  transform: translateX(-50%);
  width: 20px;
  height: 3px;
  background-color: #ff6600;
  border-radius: 3px;
}

.right-icons {
  display: flex;
  align-items: center;
  position: absolute;
  right: 10px;
}

.right-icons .van-icon {
  margin-left: 12px;
  color: #333;
}
</style> 