<template>

  <div class="card">
    <div class="card-caption">Our Business Scope</div>
    <div v-for="[k, v] in Object.entries(s.cat__providers)" :key="k">

      <div class="pt-1">
        <b class="text-xs uppercase tracking-wider text-gray-400 leading-tight mt-3">
          {{ v.ucat.p.Caption }}
        </b>
      </div>

      <Provider v-for="ii in v.uproviders" 
        :route="props.route"
        :ucat="v.ucat" 
        :uprovider="ii" />

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

const props = defineProps(['route'])
props.route as string

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
