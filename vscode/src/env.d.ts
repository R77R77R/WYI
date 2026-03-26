/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_CLERK_PUBLISHABLE_KEY: string
  // 在这里添加你其他的环境变量类型...
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}