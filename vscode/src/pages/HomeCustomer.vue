<template>

<div>Welcome</div>

<div>https://whatsyourideal.com/</div>

<div class="mt-[20px]">
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
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import { ref } from 'vue'

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
