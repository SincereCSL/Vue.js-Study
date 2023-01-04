import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index'
import {store,key} from '@/store/index'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import '@/assets/CSS/common.scss'


createApp(App)
.use(router)
.use(store,key)
.use(ElementPlus)
.mount('#app')

