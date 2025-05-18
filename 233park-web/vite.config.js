import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { viteMockServe } from 'vite-plugin-mock'
import path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

// https://vitejs.dev/config/
export default defineConfig({
  base: '/Vue.js-Study/',
  plugins: [
    vue(),
    viteMockServe({
      mockPath: 'mock',
      supportTs: false,
      localEnabled: true,
      logger: true,
      cors: true,
      ignoreFiles: [],
      watch: true,
      esModule: true,
      prodEnabled: true,
      injectCode: `
        import { setupProdMockServer } from './mock/mockProdServer';
        setupProdMockServer();
      `,
    }),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    host: '0.0.0.0'
  }
})
