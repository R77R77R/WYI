<template>

<div class="card">

<div v-if="props.mode == 0">
  {{ props.acctx.acct.p.AcctNum }}
</div>

<div v-if="props.mode == 1">
  <div>
    {{ props.acctx.acct.p.AcctNum }}
  </div>
 
</div>

</div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const props = defineProps(['acctx','mode'])
props.acctx as wyi.AcctComplex
props.mode as number

const s = glib.vue.reactive({
  rt: runtime
})

glib.vue.onMounted(async () => {

})

</script>
