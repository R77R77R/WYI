<template>

<div>Welcome</div>

<button @click="s.rt.router.push('/UploadBills')">Upload Your Bills</button>

<div>
  <div v-for="(item,index) in s.providers">
    <div><b>{{ item.ucat }}</b>
      <span v-for="ii in item.uproviders">
        | {{ ii }}
      </span>
    </div>
  </div>
</div>


</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const s = glib.vue.reactive({
  providers: [] as any,
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {},(rep:any) => {
    s.providers = []
    rep.data.forEach((e:any) => {
      let ucat = e.ucat as wyi.UCAT
      let providers = [] as any
      e.providers.forEach((p:wyi.UPROVIDER) => {
        providers.push(p.p.Caption)  
      })
      s.providers.push({ 
        ucat:ucat.p.Caption,
        uproviders:providers })
    });
  })
})

</script>
