<template>

  <div class="flex justify-center">
    <div class="hor-range">

      <div class="card">
        <div class="card-caption">Users</div>
        <div>
          <SearchField api="/api/admin/users" 
            :item__key="user__key" :item__text="user__text" 
            @select="onSelectUser" />
        </div>
        <div v-for="i in s.users">
          {{ i.p.Email }}
        </div>
      </div>

      <div class="card">
        <div class="card-caption">Bills</div>
        <div>
          <SearchField api="/api/admin/billxs" 
            :item__key="billx__key" :item__text="billx__text" 
            @select="onSelectBillx" />
        </div>
        <div v-for="i in s.billx">
          {{ i }}
        </div>
      </div>

    </div>
  </div>

  <div class="flex justify-center">
    <div class="hor-range">




    </div>
  </div>

</template>

<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})


const user__key = (eu: wyi.EU) => {
  return eu.id
}

const user__text = (eu: wyi.EU) => {
  return eu.p.Caption
    + " " + eu.p.Username
    + " " + eu.p.Email
}

const onSelectUser = (eu: wyi.EU) => {
}


const bills__key = (billx: wyi.BillComplex) => {
  return billx.bill.id
}

const bills__text = (billx: wyi.BillComplex) => {
  return billx.bill.p.ShownAddr
}

const onSelectBillx = (billx: wyi.BillComplex) => {
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/users', {
    act: "ls"
  }, (rep: any) => {
    s.users = rep.data as wyi.EU[]
  })

})

</script>