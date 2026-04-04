<template>

<div class="h-full w-full flex flex-col p-3">

        <div class="w-[300px]">
            Preview
        </div>

        <div v-if="props.filex.rcd.id > 0">
        <div>Cat: {{ s.billx.cato?.p.Caption }}</div>
        <div>Provider: {{ s.billx.providero?.p.Caption  }}</div>
        <div>Unit: {{ s.billx.unito?.p.Caption  }}</div>
        <div>Acct Number: {{ s.billx.accto?.p.AcctNum }}</div>
        <div>Amount: {{ s.billx.bill.p.Amout }}</div>
        <div>File Name: {{ props.filex.file.name }}</div>
        <div>File Size: {{ (props.filex.file.size / 1024 / 1024).toFixed(2) }} MB</div>
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
import { BillComplex_empty } from '~/lib/shared/CustomMor'

const props = defineProps(['filex'])
props.filex as FileComplex

const s = glib.vue.reactive({
  billx: BillComplex_empty(),
  rt: runtime
})

export interface UploadTask {
    id: string
    file: File
    progress: number
    status: 'pending' | 'uploading' | 'success' | 'error'
    message?: string
}

export type FileComplex = {
    uploadTask: UploadTask,
    rcd: wyi.FILE,
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

const executeUpload = async (task: UploadTask) => {
    task.status = 'uploading';
    task.progress = 0; // 重置为 0，交给 XHR 动态更新

    // 1. 获取 Clerk 令牌 (保持异步获取)
    const clerk = (window as any).Clerk;
    const token = await clerk?.session?.getToken();

    const formData = new FormData();
    formData.append('file', task.file);
    // 注意：确保 s.rt.session 在作用域内可用，或者作为参数传入
    formData.append('session', s.rt.session); 

    // 2. 使用 Promise 包装 XHR，以便保持 async/await 的调用方式
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();

        // 【关键】监听上传进度
        xhr.upload.onprogress = (event) => {
            if (event.lengthComputable) {
                const percent = Math.round((event.loaded * 100) / event.total);
                task.progress = Math.min(percent, 99);
            }
        };

        // 监听请求完成
        xhr.onload = () => {
            if (xhr.status >= 200 && xhr.status < 300) {
                try {
                    let rep = JSON.parse(xhr.responseText);
                    if(rep.Er == "OK"){
                        props.filex.rcd = rep.file
                        s.billx = rep.billx
                    }
                    task.status = 'success';
                    task.progress = 100;
                    resolve(rep);
                } catch (e) {
                    task.status = 'error';
                    task.message = "Invalid JSON response";
                    reject("Invalid JSON");
                }
            } else {
                task.status = 'error';
                task.message = `Server Error: ${xhr.status}`;
                reject(xhr.status);
            }
        };

        // 监听网络错误
        xhr.onerror = () => {
            task.status = 'error';
            task.message = "Network error or file too large";
            console.error("Upload failed");
            reject("Network error");
        };

        // 3. 配置并发送请求
        xhr.open("POST", "/api/public/upload");
        
        // 设置 Header (Clerk Token)
        if (token) {
            xhr.setRequestHeader("Authorization", `Bearer ${token}`);
        }

        xhr.send(formData);
    });
};

glib.vue.onMounted(async () => {
    executeUpload(props.filex.uploadTask)
})

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