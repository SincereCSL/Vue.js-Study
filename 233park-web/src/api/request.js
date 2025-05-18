import axios from 'axios'
import { showToast } from 'vant'

// 创建axios实例
const service = axios.create({
  baseURL: '/',
  timeout: 10000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
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