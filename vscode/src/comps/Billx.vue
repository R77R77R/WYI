<template>

<div class="card">

<div v-if="props.billx.cato && props.billx.providero">
  {{ props.billx.providero.p.Caption }}
  ({{ props.billx.cato.p.Caption }})
</div>

<div v-if="props.mode > 0">

</div>

</div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const props = defineProps(['billx','mode'])
props.billx as wyi.BillComplex
props.mode as number

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
