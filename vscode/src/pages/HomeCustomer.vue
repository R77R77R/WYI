<template>

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
