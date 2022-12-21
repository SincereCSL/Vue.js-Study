import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path' 
import * as path from 'path/posix'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [vue()],
    server: {
        host:'0.0.0.0',
        port:8000,
        open: true
      },
    resolve:{
        alias:{
            '@':path. resolve(__dirname,'src')
        }
    }

})
