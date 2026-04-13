<template>

  <div class="flex justify-center">
    <div class="hor-range">

      <div class="card">
        <div class="card-caption">Users</div>
        <div>
          <SearchField api="/api/admin/users" 
            :item__key="(eu: wyi.EU) => eu.id" 
            :item__text='(eu: wyi.EU) => eu.p.Caption + " " + eu.p.Username + " " + eu.p.Email'
            @select="onSelectUser" />
        </div>
        <div v-for="i in s.users">
          <span v-if="i.p.OAuthProvider != ''">
            {{ i.p.Email }}
            <img class="img-oauth"
              :src="'https://img.clerk.com/static/' + i.p.OAuthProvider + '.svg'" />
          </span>
          <span v-else>
            {{ i.p.Username }}
          </span>
        </div>
      </div>

      <div class="card">
        <div class="card-caption">Bills</div>
        <div>
          <button @click="s.rt.router.push('/Bills')">
            Mange bills
          </button>
        </div>
        <div>
          <SearchField api="/api/admin/billxs" 
            :item__key="(billx: wyi.BillComplex) => billx.bill.id" 
            :item__text="billx__text" 
            @select="onSelectBillx" />
        </div>
        <Billx v-for="i in s.billxs"
          :billx="i" :mode="0" />
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
import Billx from '~/comps/Billx.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})


const onSelectUser = (eu: wyi.EU) => {
}


const billx__text = (billx: wyi.BillComplex) => {
  
  let cat = ""
  if(billx.cato)
    cat = "(" + billx.cato.p.Caption + ") "

  let provider = ""
  if(billx.providero)
    provider = billx.providero.p.Caption + " "
    
  let unit = ""
  if(billx.unito){
    let p = billx.unito.p
    unit = p.Address + " " + p.Town + " " + p.State + p.Zip }
  
  return provider + cat + unit + " $" + billx.bill.p.Amt
}

const onSelectBillx = (billx: wyi.BillComplex) => {
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/users', {
    act: "ls"
  }, (rep: any) => {
    s.users = rep.data as wyi.EU[]
  })

  Common.loader('/api/admin/billxs', {
    act: "ls"
  }, (rep: any) => {
    s.billxs = rep.data as wyi.BillComplex[]
  })

})

</script>