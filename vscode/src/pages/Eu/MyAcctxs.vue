<template>

  <div class="card">
    <div class="card-caption">
      My Accounts
    </div>
  </div>

  <Acctx v-for="i in s.acctxs" 
    :acctx="i" :mode="1" />

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import StateLocator from '~/comps/StateLocator.vue'
import Acctx from '~/comps/Acctx.vue'
import { pUNIT_empty } from '~/lib/shared/OrmMor'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  acctxs: [] as wyi.AcctComplex[],
  toggleCreate: false,
  pUnit: pUNIT_empty(),
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/eu/my-acctxs', {
    act: "ls"
  }, (rep: any) => {
    s.acctxs = rep.data as wyi.AcctComplex[]
  })

})

</script>