<template>
  <div class="upload-page">
    <div class="header">
      <h2>Upload Bills</h2>
      <p v-if="s.rt.user" class="user-status">
        <strong>{{ s.rt.user.eu.p.Caption }}</strong> 
        <span class="id-tag">(ID: {{ s.rt.user.id }})</span>
      </p>
    </div>

    <div 
      class="drop-zone"
      :class="{ 'is-dragging': isDragging }"
      @dragover.prevent="isDragging = true"
      @dragleave.prevent="isDragging = false"
      @drop.prevent="onDrop"
      @click="triggerSelect"
    >
      <input 
        type="file" 
        multiple 
        ref="fileInput" 
        @change="onFileSelect" 
        hidden 
      />
      <div class="icon">📄</div>
      <p>Drop your files here or <span>Select</span></p>
      <small>Max. 10GB</small>
      <div>Utility Providers: ADT, ... see a full list.</div>
    </div>

    <div class="task-list" v-if="tasks.length > 0">
      <div v-for="task in tasks" :key="task.id" class="task-item">
        <div class="file-meta">
          <span class="file-name">{{ task.file.name }}</span>
          <span class="file-size">{{ (task.file.size / 1024 / 1024).toFixed(2) }} MB</span>
        </div>
        
        <div class="progress-container">
          <div 
            class="progress-fill" 
            :style="{ width: task.progress + '%' }"
            :class="task.status"
          ></div>
        </div>

        <div class="status-row">
          <span :class="['status-label', task.status]">
            {{ getStatusText(task) }}
          </span>
          <span v-if="task.message" class="error-detail"> - {{ task.message }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'

// 定义上传任务接口
interface UploadTask {
  id: string
  file: File
  progress: number
  status: 'pending' | 'uploading' | 'success' | 'error'
  message?: string
}

// 适配你的全局 runtime 注入逻辑
const s = glib.vue.reactive({
  rt: (window as any).runtime
})

const tasks = ref<UploadTask[]>([])
const isDragging = ref(false)
const fileInput = ref<HTMLInputElement | null>(null)

const triggerSelect = () => fileInput.value?.click()

const onFileSelect = (e: Event) => {
  const files = (e.target as HTMLInputElement).files
  handleFiles(files)
}

const onDrop = (e: DragEvent) => {
  isDragging.value = false
  handleFiles(e.dataTransfer?.files || null)
}

const handleFiles = (fileList: FileList | null) => {
  if (!fileList) return
  
  // 校验业务 Session 是否就绪 (来自你的后置 loader)
  if (!s.rt.session || s.rt.session === "null") {
    alert("Session 未就绪，请刷新页面。")
    return
  }

  Array.from(fileList).forEach(file => {
    const task: UploadTask = {
      id: Math.random().toString(36).slice(2),
      file,
      progress: 0,
      status: 'pending'
    }
    tasks.value.push(task)
    // 立即触发并行上传请求
    executeUpload(task)
  })
}

const executeUpload = async (task: UploadTask) => {
  task.status = 'uploading'
  task.progress = 20 // 模拟初始进度

  // 获取 Clerk 令牌用于后端鉴权
  const clerk = (window as any).Clerk
  const token = await clerk?.session?.getToken()

  const formData = new FormData()
  formData.append('file', task.file)
  formData.append('session', s.rt.session)

  try {
    const response = await fetch("/api/public/upload", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${token}`
      },
      body: formData
    })

    if (!response.ok) throw new Error(`Server Error: ${response.status}`)

    const result = await response.json()
    
    if (result.Er === "OK") {
      task.status = 'success'
      task.progress = 100
    } else {
      task.status = 'error'
      task.message = result.Er
    }
  } catch (err: any) {
    task.status = 'error'
    task.message = "网络异常或文件超过限制"
    console.error("Upload failed:", err)
  }
}

const getStatusText = (task: UploadTask) => {
  switch (task.status) {
    case 'uploading': return '上传中...'
    case 'success': return '完成'
    case 'error': return '失败'
    default: return '排队'
  }
}
</script>

<style scoped>
.upload-page { max-width: 800px; margin: 0 auto; padding: 2rem; }
.user-status { font-size: 0.9rem; color: #666; margin-bottom: 1.5rem; }
.drop-zone {
  border: 2px dashed #ccd0d7;
  border-radius: 8px;
  padding: 4rem 1rem;
  text-align: center;
  background: #f9fafc;
  cursor: pointer;
  transition: all 0.2s;
}
.drop-zone.is-dragging { border-color: #409eff; background: #ecf5ff; }
.icon { font-size: 3rem; margin-bottom: 1rem; }
.task-list { margin-top: 2rem; }
.task-item { 
  border: 1px solid #eee; 
  padding: 1rem; 
  border-radius: 6px; 
  margin-bottom: 1rem; 
  background: white;
}
.file-meta { display: flex; justify-content: space-between; font-size: 0.85rem; margin-bottom: 0.5rem; }
.progress-container { height: 6px; background: #ebeef5; border-radius: 3px; overflow: hidden; }
.progress-fill { height: 100%; transition: width 0.3s; }
.progress-fill.uploading { background: #409eff; }
.progress-fill.success { background: #67c23a; }
.progress-fill.error { background: #f56c6c; }
.status-row { font-size: 0.75rem; margin-top: 0.5rem; }
.status-label.success { color: #67c23a; }
.status-label.error { color: #f56c6c; }
.error-detail { color: #999; }
</style>