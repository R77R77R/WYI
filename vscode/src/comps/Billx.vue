<template>

<div class="card">


<div v-if="props.mode == 0">
  <div v-if="props.billx.cato && props.billx.providero">
    <span class="text-block">
      {{ props.billx.bill.p.State }}
    </span>
    {{ props.billx.providero.p.Caption }}
    ({{ props.billx.cato.p.Caption }})
    ${{ props.billx.bill.p.Amt }}
  </div>
</div>
<div v-if="props.mode == 1">
    <div class="text-block">
      {{ props.billx.bill.p.State }}
    </div>
  <div v-if="props.billx.cato && props.billx.providero">
    {{ props.billx.providero.p.Caption }}
    ({{ props.billx.cato.p.Caption }})
  </div>
  <div v-if="props.billx.unito">
    {{ props.billx.unito.p.Address }}
  </div>
  <div>
    <b>${{ props.billx.bill.p.Amt }}</b>
  </div>
  <div class="flex">
    <a target="_blank"
      v-for="i in props.billx.files"
      :href="'/file/'+ i.id">
      <img :src="'/thumbnail/'+ i.id" />
    </a>
  </div>
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
  rt: runtime
})

glib.vue.onMounted(async () => {

})

</script>
