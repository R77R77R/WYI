<template>

<div class="card">

<div v-if="props.mode == 0">
  <span v-if="props.acctx.cato && props.acctx.providero">
    {{ props.acctx.providero.p.Caption }}
    ({{ props.acctx.cato.p.Caption }})
  </span>
  {{ props.acctx.acct.p.AcctNum }}
</div>

<div v-if="props.mode == 1"> 
  <div class="flex" 
    v-if="props.acctx.cato && props.acctx.providero">
    Service Provider: 
    <img class="m-2"
     :src="props.acctx.providero.p.Icon" />
    {{ props.acctx.providero.p.Caption }}
    ({{ props.acctx.cato.p.Caption }})
  </div>

  <Unit v-if="props.acctx.unito"
    :unit="props.acctx.unito" :mode="1" />

  <div>
    A/C Name: {{ props.acctx.acct.p.AcctName }}
  </div>
  <div>
    A/C Num: {{ props.acctx.acct.p.AcctNum }}
  </div>
 
</div>

</div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import Unit from '~/comps/Unit.vue'

const props = defineProps(['acctx','mode'])
props.acctx as wyi.AcctComplex
props.mode as number

const s = glib.vue.reactive({
  rt: runtime
})

glib.vue.onMounted(async () => {
})

</script>
