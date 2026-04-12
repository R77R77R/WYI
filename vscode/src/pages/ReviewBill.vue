<template>

  <div class="card">
    <div class="card-caption">Review Your Bill</div>
    <div v-for="fid in s.fids">
      <div class="w-[300px]">
        <img :src='"/thumbnail/" + fid' />
      </div>
    </div>
  </div>

  <div class="card-double-col-container"
    v-if="s.er == 'OK'">

    <div class="card-double-col">
    <div class="card" v-if="s.ex != ''">
      <p>We experienced an issue from the AI.
        You can keyin the fields instead.</p>
      <p>{{ s.ex }}</p>
    </div>
    </div>

    <LocateProvider 
      :ucat="s.ucat"
      :uprovider="s.uprovider" />

    <LocateUnit 
      :unit="s.unit"
      api="/api/eu/my-units" />

    <LocateAcctx
      :ucat="s.ucat"
      :uprovider="s.uprovider"
      :unit="s.unit"
      :acctx="s.acctx"
      api="/api/eu/my-acctxs" />

    <div class="card-double-col">

      <div class="card-double-col-span">
        <div class="card-caption">Billing</div>
      </div>

      <div class="card-double-col-1">
      </div>

      <div class="card-double-col-2">
        <div>Bill Date: </div>
        <div><input v-model="s.bill.p.YYYYMMDD" /></div>

        <div>Amount: </div>
        <div><input v-model="s.bill.p.Amt" /></div>

      </div>
    
    </div>

    <div class="card-double-col">
      <div class="card-double-col-span">
        <div class="flex">
          <button @click="confirm">Confirm</button>
          the details and submit to our professional team.
        </div>
      </div>
    </div>

  </div>

  <div class="card" v-else>
    <img src="https://media.tenor.com/P6OWWkfES0YAAAAm/loading-gif-loading.webp">
    AI processing ... 20 seconds expected
  </div>

</template>


<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import { router } from '~/lib/mod/route'

import { UCAT_empty, UPROVIDER_empty, UBILL_empty, UNIT_empty } from '~/lib/shared/OrmMor'
import { AcctComplex_empty } from '~/lib/shared/CustomMor'
import LocateUnit from '~/comps/LocateUnit.vue'
import LocateAcctx from '~/comps/LocateAcctx.vue'
import LocateProvider from '~/comps/LocateProvider.vue'

const s = glib.vue.reactive({
  fids: [],
  er: "",
  ex: "",
  ucat: UCAT_empty(),
  uprovider: UPROVIDER_empty(),
  unit: UNIT_empty(),
  acctx: AcctComplex_empty(),
  bill: UBILL_empty(),
  rt: runtime
})


glib.vue.onMounted(async () => {

  try {
    let json = "" + sessionStorage.getItem('fids')
    s.fids = JSON.parse(json)
  } catch (e) {
  }

  sessionStorage.setItem('fids', JSON.stringify([]))

  Common.loader('/api/eu/review-bill-files', {
    fids: s.fids
  }, (rep: any) => {
    s.er = rep.Er
    s.ex = "" + rep.ex

    if(rep.ucat)
      s.ucat = rep.ucat
    if(rep.uprovider)
      s.uprovider = rep.uprovider

    s.unit.p = rep.pUnit
    s.acctx.acct.p = rep.pAcct
    s.bill.p = rep.pBill
  })

})

const confirm = () => {
  Common.loader('/api/eu/submit-bill', {

  }, (rep: any) => {
    router.push("/")
  })
}

</script>