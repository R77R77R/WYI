<template>

  <div class="card">
    <div>Production: <a href="https://whatsyourideal.com/" target="_blank">https://whatsyourideal.com/</a></div>
    <div>Demo: <a href="https://5.78.201.21/" target="_blank">https://5.78.201.21/</a></div>
  </div>

  <div class="card" v-if="s.rt.user != null && s.rt.user.eu.id > 0">
    <div class="card-caption">Upload and Review Your Bill</div>
    <div>
      <button @click="s.rt.router.push('/UploadBill')">GO</button>
    </div>
  </div>
  <div class="card" v-else>
    <div class="card-caption">Sign In and Review Your Bill</div>
    <div>
      <UserAuth />
    </div>
  </div>

  <div class="card">
    <div class="card-caption">Our Business Scope</div>
    <div v-for="[k, v] in Object.entries(s.cat__providers)" :key="k">

      <div class="pt-1">
        <b class="text-xs uppercase tracking-wider text-gray-400 leading-tight mt-3">
          {{ v.ucat.p.Caption }}
        </b>
      </div>

      <Provider v-for="ii in v.uproviders" :uprovider="ii" />

    </div>
  </div>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import UserAuth from '~/comps/UserAuth.vue'
import Provider from '~/comps/Provider.vue'

import { ref } from 'vue'

type CatProviders = {
  ucat: wyi.UCAT,
  uproviders: wyi.UPROVIDER[]
}

const s = glib.vue.reactive({
  cat__providers: {} as { [key: number]: CatProviders },
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {}, (rep: any) => {
    s.cat__providers = {}
    rep.data.forEach((e: any) => {
      let ucat = e.ucat as wyi.UCAT
      let uproviders = e.providers as wyi.UPROVIDER[]
      let item: CatProviders = {
        ucat: ucat,
        uproviders: uproviders
      }
      s.cat__providers[ucat.id] = item
    });
  })

})

</script>
