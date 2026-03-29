<template>
  <div class="upload-page">
    <div class="header">
      <h2>账单上传</h2>
      <p v-if="s.rt.user" class="user-status">
        当前操作员: <strong>{{ s.rt.user.p?.Caption }}</strong> 
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
      <p>将账单文件拖拽到此处，或 <span>点击选择文件</span></p>
      <small>支持并行上传多个文件 (PDF, 图片)</small>
    </div>

    <div class="task-list" v-if="tasks.length > 0">
      <div v-for="task in tasks" :key="task.id" class="task-item">
        <div class="file-meta">
          <span class="file-name">{{ task.file.name }}</span>
          <span class="file-size">{{ (task.file.size / 1024).toFixed(1) }} KB</span>
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
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'

interface UploadTask {
  id: string
  file: File
  progress: number
  status: 'pending' | 'uploading' | 'success' | 'error'
}

const s = glib.vue.reactive({
  rt: runtime
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
  
  // 业务逻辑检查：确保 Session 已由 loader 注入
  if (!runtime.session || runtime.session === "null") {
    alert("系统尚未就绪，请稍后刷新页面再试。")
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
    // 触发并行上传
    executeUpload(task)
  })
}

const executeUpload = async (task: UploadTask) => {
  task.status = 'uploading'
  
  // 1. 获取 Clerk Token，使用可选链修复 18049 错误
  // 这里将 window 强制转为 any 以跳过复杂的 Clerk 类型定义检查
  const clerk = (window as any).Clerk
  const token = await clerk?.session?.getToken()

  if (!token) {
    task.status = 'error'
    console.error("未能获取有效的 Clerk Token")
    return
  }

  const formData = new FormData()
  formData.append('file', task.file)
  // 将业务 Session ID 注入，供后端关联用户 (1003)
  formData.append('session', runtime.session)

  try {
    const response = await fetch("/api/public/upload", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${token}`
      },
      body: formData
    })

    const result = await response.json()
    if (result.Er === "OK") {
      task.status = 'success'
      task.progress = 100
    } else {
      task.status = 'error'
    }
  } catch (err) {
    task.status = 'error'
    console.error("网络上传异常:", err)
  }
}

const getStatusText = (task: UploadTask) => {
  switch (task.status) {
    case 'uploading': return '上传中...'
    case 'success': return '已完成'
    case 'error': return '失败'
    default: return '排队中'
  }
}
</script>

<style scoped>
.upload-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: sans-serif;
}

.header { margin-bottom: 30px; }
.user-status { color: #666; font-size: 14px; }
.id-tag { color: #999; margin-left: 8px; }

.drop-zone {
  border: 2px dashed #dcdfe6;
  border-radius: 12px;
  background: #fbfdff;
  padding: 60px 20px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
}

.drop-zone:hover, .drop-zone.is-dragging {
  border-color: #409eff;
  background: #f0f7ff;
}

.icon { font-size: 48px; margin-bottom: 15px; }
.drop-zone span { color: #409eff; font-weight: bold; }

.task-list { margin-top: 30px; }
.task-item {
  background: #fff;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 12px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.file-meta { display: flex; justify-content: space-between; margin-bottom: 10px; }
.file-name { font-weight: 500; color: #303133; }
.file-size { color: #909399; font-size: 13px; }

.progress-container {
  height: 8px;
  background: #f5f7fa;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 8px;
}

.progress-fill {
  height: 100%;
  transition: width 0.3s ease;
}

.progress-fill.uploading { background-color: #409eff; }
.progress-fill.success { background-color: #67c23a; }
.progress-fill.error { background-color: #f56c6c; }

.status-label { font-size: 12px; }
.status-label.success { color: #67c23a; }
.status-label.error { color: #f56c6c; }
.status-label.uploading { color: #409eff; }
</style>