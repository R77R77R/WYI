<template>

  <div class="card">
    <div>Production: <a href="https://whatsyourideal.com/" target="_blank">https://whatsyourideal.com/</a></div>
    <div>Demo: <a href="https://5.78.201.21/" target="_blank">https://5.78.201.21/</a></div>
  </div>
  
  <div class="card"
    v-if="s.rt.user != null && s.rt.user.eu.id > 0">
    <div class="card-caption">Upload and Review Your Bill</div>
    <div>
      <button @click="s.rt.router.push('/UploadBill')">GO</button>
    </div>
  </div>
  <div class="card"
    v-else>
    <div class="card-caption">Sign In and Review Your Bill</div>
    <div>
      <UserAuth />
    </div>
  </div>

  <div class="card">
    <div class="card-caption">Our Business Scope</div>
    <div v-for="(item, index) in s.providers" :key="index"
      class="grid grid-cols-[100px_1fr] gap-x-6 py-3 border-b border-gray-50 items-start">

      <div class="pt-1">
        <b class="text-xs uppercase tracking-wider text-gray-400 leading-tight">
          {{ item.ucat.p.Caption }}
        </b>
      </div>

      <div class="flex flex-wrap gap-3">
        <Provider v-for="ii in (item.uproviders as wyi.UPROVIDER[])" :uprovider="ii" />
      </div>

    </div>
  </div>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import Provider from '~/comps/Provider.vue'
import UserAuth from '~/comps/UserAuth.vue'

import { ref } from 'vue'

const s = glib.vue.reactive({
  providers: [] as any[],
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {}, (rep: any) => {
    s.providers = []
    rep.data.forEach((e: any) => {
      let ucat = e.ucat as wyi.UCAT
      let providers = [] as wyi.UPROVIDER[]
      e.providers.forEach((p: wyi.UPROVIDER) => {
        providers.push(p)
      })
      s.providers.push({
        ucat: ucat,
        uproviders: providers
      })
    });
  })
})

</script>
