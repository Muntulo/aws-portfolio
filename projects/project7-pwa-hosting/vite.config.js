import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      devOptions: { enabled: true },
      workbox: { navigateFallback: '/index.html' },
      manifest: {
        name: 'Gustavo Guerra AWS PWA Portfolio',
        short_name: 'AWS PWA',
        description: 'My AWS projects as a Progressive Web App',
        theme_color: '#232f3e',
        icons: []
      }
    })
  ]
})