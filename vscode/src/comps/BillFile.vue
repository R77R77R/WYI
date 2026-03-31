<template>

    <div class="h-full w-full flex flex-col p-3">

    <div>Preview</div>
    <div>Unit</div>
    <div>Provider</div>
    <div>Amount</div>

        <div class="file-meta">
            <span class="file-name">{{ props.filex.file.name }}</span>
            <span class="file-size">{{ (props.filex.file.size / 1024 / 1024).toFixed(2) }} MB</span>
        </div>

        <div class="progress-container">
            <div class="progress-fill" :style="{ width: props.filex.uploadTask.progress + '%' }"
                :class="filex.uploadTask.status"></div>
        </div>

        <div class="status-row">
            <span :class="['status-label', props.filex.uploadTask.status]">
                {{ getStatusText(props.filex.uploadTask) }}
            </span>
            <span v-if="props.filex.uploadTask.message" class="error-detail"> - {{ props.filex.uploadTask.message }}</span>
        </div>

    </div>

</template>

<script setup lang="ts">

import { getCurrentInstance, toRefs, watch } from 'vue'
import { glib } from '~/lib/glib'
import { ref } from 'vue'
import * as Common from '~/lib/store/common'

const props = defineProps(['filex'])
props.filex as FileComplex

export interface UploadTask {
    id: string
    file: File
    progress: number
    status: 'pending' | 'uploading' | 'success' | 'error'
    message?: string
}

export type FileComplex = {
    uploadTask: UploadTask,
    file: File
}


const getStatusText = (task: UploadTask) => {
  switch (task.status) {
    case 'uploading': return 'Uploading ...'
    case 'success': return 'Succeeded'
    case 'error': return 'Failed'
    default: return 'Pending ...'
  }
}

</script>


<style scoped>
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