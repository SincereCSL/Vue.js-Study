import axios from 'axios'
import { showToast } from 'vant'

// 判断是否在GitHub Pages环境
const isGitHubPages = window.location.href.includes('github.io')

// 创建axios实例
const service = axios.create({
  baseURL: isGitHubPages ? '/Vue.js-Study/233park-web' : '/',
  timeout: 10000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    // GitHub Pages环境下重写请求路径，使用静态JSON
    if (isGitHubPages && config.url === '/api/discovery') {
      const type = config.params.type || 'recommend'
      config.url = `/api/discovery/${type}.json`
    }
    return config
  },
  error => {
    console.log(error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    
    if (res.code !== 0) {
      showToast({
        message: res.message || '请求失败',
        type: 'fail',
        duration: 2000
      })
      return Promise.reject(new Error(res.message || '请求失败'))
    } else {
      return res
    }
  },
  error => {
    console.log('请求错误：', error)
    showToast({
      message: error.message || '请求失败',
      type: 'fail',
      duration: 2000
    })
    return Promise.reject(error)
  }
)

export default service
