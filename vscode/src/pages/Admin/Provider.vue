<template>

  <div class="card">
    <div class="card-caption" 
      v-if="s.ucat.id > 0 && s.view.uprovider.id > 0">
      {{ s.view.uprovider.p.Caption }}
      ({{ s.ucat.p.Caption }})
    </div>
  </div>

  <div class="card">
    <div class="card-caption">
      Bill Pools
    </div>

    <PoolStates />

    <div class="flex">
      Caption: <input v-model="s.item.p" />
      <button @click="createPool()">Create Bill Pool</button>
    </div>

  </div>

  <Pool v-for="i in s.view.pools" :pool="i" />

  <div class="card" v-if="s.view.billxs.length > 0">
    <div class="card-caption">
      Bills
    </div>

    <BillStates />

    <Billx v-for="i in s.view.billxs" :billx="i" :mode="1" />

  </div>

</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'
import { pPOOL_empty, UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'
import Pool from '~/comps/Pool.vue'
import PoolStates from '~/comps/PoolStates.vue'
import BillStates from '~/comps/BillStates.vue'
import Billx from '~/comps/Billx.vue'
import { ProviderView_empty } from '~/lib/shared/CustomMor';

const props = defineProps(['cat','provider'])
props.cat as string
props.provider as string

const s = glib.vue.reactive({
  ucat: UCAT_empty(),
  view: ProviderView_empty(),
  item: pPOOL_empty(),
  rt: runtime
})

const createPool = () => {

  s.item.p.Provider = s.view.uprovider.id
  Common.loader('/api/admin/pools', {
    p: s.item.p,
    act: "create"
  }, (rep: any) => {
    let pool = rep.data as wyi.POOL
    s.view.pools.push(pool)
    s.item = pPOOL_empty()
  })
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/providers', {
    cat: props.cat,
    provider: props.provider,
    act: 'load'
  }, (rep: any) => {
    //s.ucat = rep.cat
    console.log(rep)
    s.view = rep.data as wyi.ProviderView
  })

})

</script>