import { createApp } from 'vue'
import './style.css'
import App from './App.vue'

// 引入Vant组件库
import Vant from 'vant'
import 'vant/lib/index.css'

// 移动端适配
import 'amfe-flexible/index.js'

const app = createApp(App)
app.use(Vant)
app.mount('#app')
