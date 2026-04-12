<template>

<div class="max-w-5xl mx-auto flex flex-col space-y-px bg-gray-100 border border-gray-100">
  
  <div class="grid grid-cols-2 gap-x-8 bg-gray-50 px-4 py-2 text-xs font-bold text-gray-400 uppercase tracking-widest">
    <div class="flex items-center">Source / 原文</div>
    <div class="flex items-center border-l border-gray-200 pl-8">Translation / 译文</div>
  </div>

  <div class="grid grid-cols-2 gap-x-8 bg-white px-4 py-2 hover:bg-blue-50/50 transition-colors group">
    
    <div class="flex items-start gap-2 py-1">
      <img src="https://icon.horse/icon/verizon.com" 
           class="h-[1em] w-auto object-contain flex-shrink-0 mt-1" />
      <span class="text-sm leading-relaxed text-gray-800 font-medium">
        Verizon Fios
      </span>
    </div>

    <div class="flex items-start py-1 border-l border-gray-100 pl-8">
      <span class="text-sm leading-relaxed text-gray-500 border-b border-transparent group-hover:border-blue-200 transition-all">
        威瑞森光纤业务
      </span>
    </div>

  </div>

  <div class="grid grid-cols-2 gap-x-8 bg-white px-4 py-2 hover:bg-blue-50/50 transition-colors group border-t border-gray-50">
    <div class="flex items-start gap-2 py-1">
      <img src="https://icon.horse/icon/xfinity.com" class="h-[1em] w-auto object-contain flex-shrink-0 mt-1" />
      <span class="text-sm leading-relaxed text-gray-800 font-medium">Comcast</span>
    </div>
    <div class="flex items-start py-1 border-l border-gray-100 pl-8">
      <span class="text-sm leading-relaxed text-gray-500">康卡斯特</span>
    </div>
  </div>

</div>


<div class="card">
  <div>Welcome</div>
  <div>https://whatsyourideal.com/</div>
</div>

<div class="mt-[20px] card">
  <div v-for="(item,index) in s.providers">
    <div><b>{{ item.ucat.p.Caption }}</b>
      <Provider
        v-for="ii in (item.uproviders as wyi.UPROVIDER[])"
        :uprovider="ii" />
    </div>
  </div>
</div>

<div v-for="(item, index) in s.providers" :key="index" 
     class="grid grid-cols-[100px_1fr] gap-x-6 py-3 border-b border-gray-50 items-start">
  
  <div class="pt-1">
    <b class="text-xs uppercase tracking-wider text-gray-400 leading-tight">
      {{ item.ucat.p.Caption }}
    </b>
  </div>

  <div class="flex flex-wrap gap-3">
    <Provider
      v-for="ii in (item.uproviders as wyi.UPROVIDER[])"
      :uprovider="ii" />
  </div>

</div>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import Provider from '~/comps/Provider.vue'

import { ref } from 'vue'

const s = glib.vue.reactive({
  providers: [] as any[],
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {},(rep:any) => {
    s.providers = []
    rep.data.forEach((e:any) => {
        let ucat = e.ucat as wyi.UCAT
        let providers = [] as wyi.UPROVIDER[]
        e.providers.forEach((p:wyi.UPROVIDER) => {
          providers.push(p)  
        })
        s.providers.push({ 
          ucat:ucat,
          uproviders:providers })
    });
  })
})

</script>
