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
    </div>
    <div>Utility Providers: ADT, ... see a full list.</div>

    <div>File list</div>
    <div class="flex flex-wrap gap-4 p-4">
        <BillFile class="w-48 h-32 bg-slate-100 border-2 border-dashed border-slate-300 rounded-lg flex items-center justify-center" 
            v-for="filex in s.filexs"
            :filex="filex"></BillFile>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'

import BillFile from '~/comps/BillFile.vue'
import { UploadTask, FileComplex } from '~/comps/BillFile.vue'


// 适配你的全局 runtime 注入逻辑
const s = glib.vue.reactive({
  filexs: [] as FileComplex[],
  rt: runtime
})

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
  /*
  if (!s.rt.session || s.rt.session === "null") {
    alert("Session 未就绪，请刷新页面。")
    return
  }
  //*/

  Array.from(fileList).forEach(file => {
    const task: UploadTask = {
      id: Math.random().toString(36).slice(2),
      file,
      progress: 0,
      status: 'pending'
    }

    // 立即触发并行上传请求
    executeUpload(task)

    s.filexs.push({ uploadTask: task, file: file})
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
    task.message = "Network error or file too large"
    console.error("Upload failed:", err)
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
</style>