<template>

  <div class="card">
    <div class="card-caption" v-if="s.ucat.id > 0 && s.uprovider.id > 0">
      {{ s.uprovider.p.Caption }}
      ({{ s.ucat.p.Caption }})
    </div>
  </div>

  <div class="card">
    <div class="card-caption">
      Bill Pools
    </div>

    <PoolStates />

    <button @click="createPool()">Create Bill Pool</button>

  </div>

  <Poolx v-for="i in s.poolxs" :poolx="i" />

  <div class="card" v-if="s.billxs.length > 0">
    <div class="card-caption">
      Bills
    </div>

    <BillStates />

    <Billx v-for="i in s.billxs" :billx="i" :mode="1" />

  </div>

</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'
import Poolx from '~/comps/Poolx.vue'
import PoolStates from '~/comps/PoolStates.vue'
import BillStates from '~/comps/BillStates.vue'
import Billx from '~/comps/Billx.vue'

const props = defineProps({
  cat: String,
  provider: String
})

const s = glib.vue.reactive({
  ucat: UCAT_empty(),
  uprovider: UPROVIDER_empty(),
  billxs: [] as wyi.BillComplex[],
  poolxs: [] as wyi.PoolComplex[],
  rt: runtime
})

const createPool = () => {

  Common.loader('/api/admin/poolxs', {
    data: {
      provider: s.uprovider.id
    },
    act: "create"
  }, (rep: any) => {
    let poolx = rep.data as wyi.PoolComplex
    s.poolxs.push(poolx)
  })
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/providers', {
    cat: props.cat,
    provider: props.provider,
    act: 'load'
  }, (rep: any) => {
    //s.ucat = rep.cat
    s.uprovider = rep.provider,
      s.billxs = rep.billxs
  })

  Common.loader('/api/admin/poolxs', {
    act: "ls"
  }, (rep: any) => {
    s.poolxs = rep.data as wyi.PoolComplex[]
  })


})

</script>