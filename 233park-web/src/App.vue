<script setup>
import { ref, onMounted, watch } from 'vue'
import TopNav from './components/TopNav.vue'
import WaterfallList from './components/WaterfallList.vue'
import { getDiscoveryList } from './api/discovery'

// 当前选中的标签页
const currentTab = ref('recommend')

// 帖子数据列表
const postsList = ref([])

// 分页和加载状态
const loading = ref(false)
const finished = ref(false)
const refreshing = ref(false)
const currentPage = ref(1)

// 获取帖子列表数据
const fetchPosts = async (isRefresh = false) => {
  const params = {
    type: currentTab.value,
    page: currentPage.value,
    pageSize: 10
  }
  
  try {
    const res = await getDiscoveryList(params)
    if (isRefresh) {
      postsList.value = res.data.list
    } else {
      postsList.value = [...postsList.value, ...res.data.list]
    }
    
    loading.value = false
    if (refreshing.value) refreshing.value = false
    
    // 判断是否加载完所有数据
    if (!res.data.hasMore) {
      finished.value = true
    } else {
      currentPage.value++
    }
  } catch (error) {
    console.error('获取数据失败', error)
    loading.value = false
    if (refreshing.value) refreshing.value = false
  }
}

// 加载更多数据
const onLoad = () => {
  if (refreshing.value) {
    currentPage.value = 1
    finished.value = false
  }
  fetchPosts()
}

// 下拉刷新
const onRefresh = () => {
  currentPage.value = 1
  finished.value = false
  loading.value = true
  fetchPosts(true)
}

// 监听标签页切换，重新加载数据
watch(currentTab, () => {
  currentPage.value = 1
  finished.value = false
  postsList.value = []
  loading.value = true
  fetchPosts(true)
})

// 初始化加载数据
onMounted(() => {
  loading.value = true
  fetchPosts()
})
</script>

<template>
  <div class="app-container">
    <TopNav v-model:currentTab="currentTab" />
    
    <!-- 主内容区域 -->
    <div class="content-area">
      <van-pull-refresh v-model="refreshing" @refresh="onRefresh">
        <van-list
          v-model:loading="loading"
          :finished="finished"
          finished-text="没有更多了"
          @load="onLoad"
        >
          <WaterfallList :posts="postsList" />
        </van-list>
      </van-pull-refresh>
    </div>
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  font-family: 'PingFang SC', 'Helvetica Neue', Helvetica, 'Microsoft YaHei', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f7f8fa;
  color: #333;
}

.app-container {
  max-width: 100vw;
  min-height: 100vh;
  position: relative;
  padding-top: 0;
  background-color: #fff;
}

.content-area {
  padding-bottom: 50px;
  padding-top: 10px;
  background-color: #f7f8fa;
}

/* 覆盖van-pull-refresh的默认样式 */
:deep(.van-pull-refresh__head) {
  top: 44px;
}
</style>
