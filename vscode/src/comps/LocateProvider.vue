<template>

  <div class="card-double-col">

    <div class="card-double-col-span">

      <div class="card-caption">Service Provider</div>

      <div class="border-blue-300 m-3">
        <span class="card-clickable m-3"
          v-for="[k,v] in Object.entries(s.cat__providers)"
          @click="s.selectedCat = v.ucat">
            <span v-if="s.selectedCat.id == v.ucat.id">
              <b>{{ v.ucat.p.Caption }}</b>
            </span>
            <span v-else>
              {{ v.ucat.p.Caption }}
            </span>
        </span>
      </div>

      <div class="border-blue-300 m-3"
        v-if="s.selectedCat.id > 0">
          <Provider class="card-clickable m-3"
            @click="s.selectedProvider = ii"
            v-for="ii in s.cat__providers[s.selectedCat.id].uproviders"
            :uprovider="ii"
            :highlight="s.selectedProvider.id == ii.id" />
      </div>

    </div>

  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import Provider from '~/comps/Provider.vue'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor'

const props = defineProps(['ucat','uprovider'])
props.ucat as wyi.UCAT
props.uprovider as wyi.UPROVIDER


type CatProviders = {
ucat: wyi.UCAT,
uproviders: wyi.UPROVIDER[]
}

const s = glib.vue.reactive({
  cat__providers: {} as {[key:number]: CatProviders},
  selectedCat: UCAT_empty(),
  selectedProvider: UPROVIDER_empty(),
  rt: runtime
})

glib.vue.onMounted(async () => {

  s.selectedCat = props.ucat
  s.selectedProvider = props.uprovider

  Common.loader('/api/public/providers', {}, (rep: any) => {
    s.cat__providers = {}
    rep.data.forEach((e: any) => {
      let ucat = e.ucat as wyi.UCAT
      let uproviders = e.providers as wyi.UPROVIDER[]
      let item:CatProviders = {
        ucat: ucat,
        uproviders: uproviders
      }
      s.cat__providers[ucat.id] = item
    });
  })

})


</script>