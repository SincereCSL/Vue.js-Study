import Mock from 'mockjs'

// 游戏类型帖子
const gamePostsData = {
  code: 0,
  data: {
    hasMore: true,
    list: [
      {
        id: 1,
        title: '[版本前瞻] 手游新版本预告——重置巢穴型，部分恐龙新羽毛',
        author: '游戏云',
        authorAvatar: 'https://picsum.photos/50/50?random=101',
        likes: 10,
        cover: 'https://picsum.photos/400/200?random=1',
        type: 'image',
        tag: '游戏'
      },
      {
        id: 2,
        title: '三角洲行动: 全面战场题味性升级, 夺旗, 攻防合集, 来玩',
        author: '玩家俱乐部',
        authorAvatar: 'https://picsum.photos/50/50?random=102',
        likes: 644,
        cover: 'https://picsum.photos/400/200?random=2',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '游戏'
      },
      {
        id: 3,
        title: '[推荐地图一瞥花酒楼] 第三期',
        author: '我是你的美食家',
        authorAvatar: 'https://picsum.photos/50/50?random=103',
        likes: 9,
        cover: 'https://picsum.photos/400/200?random=3',
        type: 'image',
        tag: '游戏'
      },
      {
        id: 4,
        title: '梅雨沙漠挡不住技巧！用这番垂直上一层楼',
        author: '沙漠掘金',
        authorAvatar: 'https://picsum.photos/50/50?random=104',
        likes: 23,
        cover: 'https://picsum.photos/400/200?random=4',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '游戏'
      },
      {
        id: 5,
        title: '阿尔法测试结束，感谢各位玩家的参与和反馈',
        author: '开发日志',
        authorAvatar: 'https://picsum.photos/50/50?random=105',
        likes: 127,
        cover: 'https://picsum.photos/400/200?random=5',
        type: 'image',
        tag: '游戏'
      },
      {
        id: 6,
        title: '新手玩家福利：十大必学技巧分享',
        author: '游戏导师',
        authorAvatar: 'https://picsum.photos/50/50?random=106',
        likes: 88,
        cover: 'https://picsum.photos/400/200?random=6',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '游戏'
      }
    ]
  },
  message: 'success'
}

// 推荐类型帖子
const recommendPostsData = {
  code: 0,
  data: {
    hasMore: true,
    list: [
      {
        id: 1,
        title: '【共筑家园🏠】黄在猪猪网里的小镇🌈🎈🐖',
        author: '小猪警官',
        authorAvatar: 'https://picsum.photos/50/50?random=201',
        likes: 79,
        cover: 'https://picsum.photos/400/200?random=101',
        type: 'image',
        tag: '推荐'
      },
      {
        id: 2,
        title: '夏日限定甜品制作，草莓牛奶冰淇淋',
        author: '甜品大师',
        authorAvatar: 'https://picsum.photos/50/50?random=202',
        likes: 45,
        cover: 'https://picsum.photos/400/200?random=102',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '推荐'
      },
      {
        id: 3,
        title: '阿姨，空千斤，天下第一舞',
        author: '青空千斤',
        authorAvatar: 'https://picsum.photos/50/50?random=203',
        likes: 32,
        cover: 'https://picsum.photos/400/200?random=103',
        type: 'image',
        tag: '推荐'
      },
      {
        id: 4,
        title: '大橘无情，家猫日常记录',
        author: '大橘无情',
        authorAvatar: 'https://picsum.photos/50/50?random=204',
        likes: 107,
        cover: 'https://picsum.photos/400/200?random=104',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '推荐'
      },
      {
        id: 5,
        title: '阿舒，你太美了，菜市场偶遇大明星',
        author: '追星少女',
        authorAvatar: 'https://picsum.photos/50/50?random=205',
        likes: 67,
        cover: 'https://picsum.photos/400/200?random=105',
        type: 'image',
        tag: '推荐'
      },
      {
        id: 6,
        title: '手工DIY：旧物改造再利用',
        author: '创意无限',
        authorAvatar: 'https://picsum.photos/50/50?random=206',
        likes: 37,
        cover: 'https://picsum.photos/400/200?random=106',
        type: 'video',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        tag: '推荐'
      }
    ]
  },
  message: 'success'
}

// 分页模拟函数
function getPaginatedData(data, page, pageSize) {
  const clonedData = JSON.parse(JSON.stringify(data))
  const totalItems = clonedData.data.list.length
  const start = (page - 1) * pageSize
  const end = Math.min(start + pageSize, totalItems)
  
  // 模拟更多数据
  if (end >= totalItems && page < 5) {
    // 随机生成更多数据
    const moreItems = Mock.mock({
      [`list|${pageSize}`]: [{
        'id|+1': totalItems + 1,
        'title': '@ctitle(10, 30)',
        'author': '@cname',
        'authorAvatar': function() {
          return `https://picsum.photos/50/50?random=${Mock.Random.integer(300, 1000)}`
        },
        'likes|1-1000': 1,
        'cover': function() {
          return `https://picsum.photos/400/200?random=${Mock.Random.integer(200, 1000)}`
        },
        'type|1': ['image', 'video'],
        'videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4',
        'tag': data === gamePostsData ? '游戏' : '推荐'
      }]
    }).list
    
    clonedData.data.list = clonedData.data.list.concat(moreItems)
    clonedData.data.hasMore = page < 4 // 第5页后没有更多数据
  } else if (page >= 5) {
    clonedData.data.hasMore = false
  }
  
  // 返回分页数据
  const result = JSON.parse(JSON.stringify(clonedData))
  result.data.list = result.data.list.slice(start, start + pageSize)
  return result
}

const mockConfig = [
  {
    url: '/api/discovery',
    method: 'get',
    response: (req) => {
      const { type = 'recommend', page = 1, pageSize = 10 } = req.query
      
      let responseData
      if (type === 'game') {
        responseData = getPaginatedData(gamePostsData, parseInt(page), parseInt(pageSize))
      } else {
        responseData = getPaginatedData(recommendPostsData, parseInt(page), parseInt(pageSize))
      }
      
      return responseData
    }
  }
]

export default mockConfig 