<template>
  <div class="upload-page">
    <div class="header">
      <h2>Upload Bills</h2>
    </div>

    <div>
      <p>Drop your files here or <span>Select</span></p>
      <small>Max. 10GB</small>
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
    </div>

    <div>File list</div>
    <div class="flex flex-wrap gap-4 p-4">
        <BillFile class="w-48 h-32 bg-slate-100 border-2 border-dashed border-slate-300 rounded-lg flex" 
            v-for="filex in s.filexs"
            :filex="filex"></BillFile>
    </div>

    <div>
      <button @click="upload">Upload</button>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'

import BillFile from '~/comps/BillFile.vue'
import { FileComplex } from '~/comps/BillFile.vue'
import { FILE_empty } from '~/lib/shared/OrmMor'
import { router } from '~/lib/mod/route'

const s = glib.vue.reactive({
  filexs: [] as FileComplex[],
  rep: {},
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
  
  Array.from(fileList).forEach(file => {

    let filex = { 
      uploadTask: {}, 
      rcd: FILE_empty(),
      file: file} as FileComplex

    filex.uploadTask = {
      id: Math.random().toString(36).slice(2),
      file,
      progress: 0,
      status: 'pending'
    }
    
    s.filexs.push(filex)
  })
}

const upload = async() => {

  let fids: number[] =
    s.filexs.map<number>((filex:FileComplex) =>
      filex.rcd.id )

  sessionStorage.setItem('fids', JSON.stringify(fids))

  await router.push('/ReviewBills')
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