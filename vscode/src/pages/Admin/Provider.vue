<template>

  <div class="card">
    <Provider :uprovider="s.view.uprovider" />
  </div>

  <div class="card">
    <div class="card-caption">
      Bill Pools
    </div>

    <PoolStates />

    <div class="form">
      <div>Caption:</div>
      <div>
        <input v-model="s.pool.p.Caption" />
      </div>
      <div v-if="s.pool.id == 0">
        <button @click="createPool()">Create</button>
      </div>
      <div v-else>
        <button @click="createPool()">Edit</button>
      </div>
    </div>

  </div>

  <Pool v-for="i in s.view.pools" 
    :pool="i" :mode="1" />

  <div class="card" v-if="s.view.billxs.length > 0">
    <div class="card-caption">
      Bills
    </div>

    <BillStates />

    <Billx v-for="i in s.view.billxs" 
      :billx="i" :mode="0" />

  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import { POOL_empty, pPOOL_empty, UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'
import Pool from '~/comps/Pool.vue'
import Provider from '~/comps/Provider.vue'
import PoolStates from '~/comps/PoolStates.vue'
import BillStates from '~/comps/BillStates.vue'
import Billx from '~/comps/Billx.vue'
import { ProviderView_empty } from '~/lib/shared/CustomMor';

const props = defineProps(['cat', 'provider'])
props.cat as string
props.provider as string

const s = glib.vue.reactive({
  ucat: UCAT_empty(),
  view: ProviderView_empty(),
  pool: POOL_empty(),
  rt: runtime
})

const createPool = () => {

  s.pool.p.Provider = s.view.uprovider.id
  Common.loader('/api/admin/pools', {
    p: s.pool.p,
    act: "create"
  }, (rep: any) => {
    let pool = rep.data as wyi.POOL
    s.view.pools.push(pool)
    s.pool = POOL_empty()
  })
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/providers', {
    cat: props.cat,
    provider: props.provider,
    act: 'load'
  }, (rep: any) => {
    s.view = rep.data as wyi.ProviderView
  })

})

</script>