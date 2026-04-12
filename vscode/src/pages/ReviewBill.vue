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
    v-if="s.rep.Er == 'OK'">

    <div class="card-double-col">
    <div class="card" v-if="s.rep.Ex != ''">
      <p>We experienced an issue from the AI.
        You can keyin the fields instead.</p>
      <p>{{ s.rep.Ex }}</p>
    </div>
    </div>

    <LocateProvider 
      :ucat="UCAT_empty()"
      :uprovider="UPROVIDER_empty()" />

    <LocateUnit 
      :unit="UNIT_empty()"
      api="/api/eu/my-units" />

    <LocateAcctx
      :acctx="AcctComplex_empty()"
      api="/api/eu/my-acctxs" />

    <LocateUnit 
      :pbill="s.rep.data.bill"
      api="/api/eu/my-units" />

    <div class="card-double-col">

      <div class="card-double-col-span">
        <div class="card-caption">Billing</div>
      </div>

      <div class="card-double-col-1">
      </div>

      <div class="card-double-col-2">
        <div>Bill Date: </div>
        <div><input v-model="s.rep.data.bill.p.BillDate" /></div>

        <div>Amount: </div>
        <div><input v-model="s.rep.data.bill.p.Amt" /></div>

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

import LocateUnit from '~/comps/LocateUnit.vue'
import { UNIT_empty } from '~/lib/shared/OrmMor'
import LocateAcctx from '~/comps/LocateAcctx.vue'
import { AcctComplex_empty } from '~/lib/shared/CustomMor'
import LocateProvider from '~/comps/LocateProvider.vue'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor'


const s = glib.vue.reactive({
  fids: [],
  rep: {} as any,
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
    s.rep = rep
    console.log(s.rep)
  })

})

const confirm = () => {
  Common.loader('/api/eu/submit-bill', {
    data: s.rep.data
  }, (rep: any) => {
    router.push("/")
  })
}

</script>