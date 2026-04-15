<template>

  <div class="card">
    <div class="card-caption">
      Bill Pools
    </div>

    <PoolStates />

  </div>

  <Poolx v-for="i in s.poolxs" :poolx="i" />

  <div class="card">
    <div class="card-caption">
      Bills
    </div>

    <BillStates />

  </div>

  <Billx v-for="i in s.billxs" :billx="i" :mode="1" />

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import Billx from '~/comps/Billx.vue'
import BillStates from '~/comps/BillStates.vue'
import Poolx from '~/comps/Poolx.vue'
import PoolStates from '~/comps/PoolStates.vue'
import Provider from './Provider.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  poolxs: [] as wyi.PoolComplex[],
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/admin/poolxs', {
    act: "ls"
  }, (rep: any) => {
    s.poolxs = rep.data as wyi.PoolComplex[]
  })

  Common.loader('/api/admin/billxs', {
    act: "ls"
  }, (rep: any) => {
    s.billxs = rep.data as wyi.BillComplex[]
  })

})

</script>