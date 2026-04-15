<template>

<div class="card">
    <div class="card-caption">
        Bill Pools
    </div>
</div>

<PoolStates />

<div class="card">
    <div class="card-caption">
        Bills
    </div>
</div>

<BillStates />

<Billx v-for="i in s.billxs"
  :billx="i" :mode="1" />

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import Billx from '~/comps/Billx.vue'
import BillStates from '~/comps/BillStates.vue'
import PoolStates from '~/comps/PoolStates.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/billxs', {
    act: "ls"
  }, (rep: any) => {
    s.billxs = rep.data as wyi.BillComplex[]
  })

})

</script>