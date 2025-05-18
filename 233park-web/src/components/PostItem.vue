<template>
  <div class="post-item">
    <div class="post-cover">
      <video
        v-if="post.type === 'video'"
        class="video-player"
        :src="post.videoUrl"
        controls
        preload="metadata"
      ></video>
      <img 
        v-else
        class="cover-image"
        :src="post.cover" 
        alt="post cover" 
      />
    </div>
    <div class="post-info">
      <div class="post-title">{{ post.title }}</div>
      <div class="post-author">
        <img :src="post.authorAvatar" class="author-avatar" alt="avatar" />
        <span class="author-name">{{ post.author }}</span>
        <div class="post-likes">
          <van-icon name="like-o" />
          <span>{{ post.likes }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  post: {
    type: Object,
    required: true
  }
})
</script>

<style scoped>
.post-item {
  border-radius: 8px;
  background-color: #fff;
  overflow: hidden;
  margin-bottom: 10px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.post-cover {
  width: 100%;
  position: relative;
  overflow: hidden;
}

.cover-image, .video-player {
  width: 100%;
  height: auto;
  object-fit: cover;
  border-radius: 8px 8px 0 0;
}

.video-player {
  max-height: 200px;
}

.post-info {
  padding: 10px;
}

.post-title {
  font-size: 14px;
  font-weight: 500;
  color: #333;
  margin-bottom: 8px;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.post-author {
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #999;
}

.author-avatar {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  margin-right: 6px;
}

.author-name {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.post-likes {
  display: flex;
  align-items: center;
}

.post-likes .van-icon {
  margin-right: 3px;
  font-size: 14px;
}
</style> 