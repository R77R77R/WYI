import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import path from 'path'
export default defineConfig({
  base: '/',
  plugins: [
    vue(),
    vueJsx()
  ],
  server: {
    host: '0.0.0.0',
    port: 2019,
    proxy: {
      '/api': {
        target: 'https://localhost', // 你的 F# 后端地址
        secure: false, // 如果是自签名证书则需设为 false
        changeOrigin: true,
        configure: (proxy, options) => {
          proxy.on('proxyReq', (proxyReq, req, res) => {
            console.log('代理发送请求:', req.method, req.url, '->', options.target + proxyReq.path);
          })}
      },

      '/thumbnail': {
        target: 'http://localhost', // 指向你的 Kestrel 端口
        changeOrigin: true,
      }      

    }
  },
  resolve: {
    alias: {
      '~/': `${path.resolve(__dirname, 'src')}/`,
      // 'katex': 'https://cdn.jsdelivr.net/npm/katex@0.16.9/+esm',
      // 'qs': 'https://cdn.jsdelivr.net/npm/qs@6.11.2/+esm',
      // "video.js": "https://cdn.jsdelivr.net/npm/video.js@8.6.1/+esm",
      // "vue": "https://cdn.jsdelivr.net/npm/vue@3.3.7/+esm",
      // "vue-router": "https://cdn.jsdelivr.net/npm/vue-router@4.2.5/+esm",
    }
  },
  build: {
    target: ['esnext'],
    outDir: './dist',
    //outDir: '../CrypTradeClubVsOpen/Deploy',
    chunkSizeWarningLimit: 3000,
    minify: false,//'esbuild',
    cssCodeSplit: true,
    rollupOptions: {
      external: [
        'three'
      ],
      output: {
        manualChunks: filePath => {
          if (filePath.includes('node_modules')) {
            switch (true) {
              default:
                return 'index'
            }
          }
          else { return 'index'}
        },
        chunkFileNames: 'js/[name].[hash].js',
        assetFileNames: 'as/[name].[hash].[ext]',
        entryFileNames: 'js/[name].[hash].js'
      }
    },
    assetsDir: 'as'
  }
})
