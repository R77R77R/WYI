<template>

<div class="card">
    <div class="card-caption">
        My Bills
    </div>
</div>

<div class="card">

    <Billx v-for="i in s.billxs"
        :billx="i" :mode="0" />

</div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import Billx from '~/comps/Billx.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/eu/my-billxs', {
    act: "ls"
  }, (rep: any) => {
    s.billxs = rep.data as wyi.BillComplex[]
  })

})

</script>