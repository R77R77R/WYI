<template>

<div v-if="props.mode == 0">
    <div class="card">
    <PoolState :state="props.pool.p.State" />
    Bill Pool: {{ props.pool.p.Caption }}
    <span
      v-if="s.poolx != null">
      for the provider:
      <Provider 
        v-if="s.poolx.providero != null"
        :uprovider="s.poolx.providero" :mode="0" />
    </span>
  </div>
</div>

<div v-else>
    
  <div class="card" 
    v-if="s.poolx != null">
    <Provider 
      v-if="s.poolx.providero != null"
      :uprovider="s.poolx.providero" />
  </div>

  <div class="card">
    <div class="card-caption">
      Bill Pool: {{ props.pool.p.Caption }}
    </div>

    <div class="card-caption"
      v-if="s.poolx.manager.id > 0">
      Manager
    </div>
  
    <User v-if="s.poolx.manager.id > 0" :eu="s.poolx.manager" />
   
  </div>

  <div class="card">
    <div class="card-caption">
      Bills
    </div>
  </div>

  <Billx v-for="(k, v) in Object.entries(s.poolx.billxs)" :billx="v" />

</div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import PoolState from '~/comps/PoolState.vue'
import Provider from '~/comps/Provider.vue'
import User from '~/comps/User.vue'
import Billx from '~/comps/Billx.vue'
import { PoolComplex__bin, PoolComplex_empty } from '~/lib/shared/CustomMor'

const props = defineProps(['pool','mode'])
props.pool as wyi.POOL
props.mode as number

const s = glib.vue.reactive({
  poolx: PoolComplex_empty(),
  rt: runtime
})

glib.vue.onMounted(async () => {
  Common.loader('/api/admin/pools', {
    id: props.pool.id,
    act: 'load'
  }, (rep: any) => {
    s.poolx = rep.data as wyi.PoolComplex
  })
})

</script>