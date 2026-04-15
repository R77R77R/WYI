<template>


</template>

<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'

const s = glib.vue.reactive({
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