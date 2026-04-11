<template>

  <div class="card">
    <div class="card-caption">Review Your Bill</div>
    <div v-for="fid in s.fids">
      <div class="w-[300px]">
        <img :src='"/thumbnail/" + fid' />
      </div>
    </div>
  </div>

  <div v-if="s.rep.Er == 'OK'">

    <div class="card" v-if="s.rep.Ex != ''">
      <p>We experienced an issue from the AI.
        You can keyin the fields instead.</p>
      <p>{{ s.rep.Ex }}</p>
    </div>

    <div class="card">
      <div class="card-caption">Your Business/Residential Unit</div>

      <div>Address: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAddr" /></div>

      <div>Town: </div>
      <div><input v-model="s.rep.data.bill.p.ShownTown" /></div>

      <div>State: </div>
      <StateLocator v-model="s.rep.data.bill.p.ShownState" />

      <div>ZIP: </div>
      <div><input v-model="s.rep.data.bill.p.ShownZip" /></div>

      <div>Match existing unit</div>
      <div>
        <SearchField api="/api/eu/my-units" :item__key="(unit: wyi.UNIT) => unit.id" :item__text="unit__text"
          @select="onSelectUnit" />
      </div>
      <Unit v-for="i in s.units" :unit="i" mode="0" />

      <div class="flex">
        <button @click="onClickNewUnit">Add as a New Unit</button>
        <div v-if="s.showUnitAdded">New Unit Added</div>
      </div>

    </div>

    <div class="card">
      <div class="card-caption">Service Provider</div>
      <div>
        <select @change="onChangeCat" v-model="s.rep.data.bill.p.Cat">
          <option v-for="item in s.ucatproviders" :value="(item.ucat as wyi.UCAT).id">
            {{ (item.ucat as wyi.UCAT).p.Caption }}
          </option>
        </select>
      </div>

      <div>Provider: {{ s.rep.data.bill.p.ShownProvider }}</div>
      <div>
        <select v-model="s.rep.data.bill.p.Provider">
          <option v-for="item in s.uproviders" :value="(item as wyi.UPROVIDER).id">
            {{ item.p.Caption }}
          </option>
        </select>
      </div>
    </div>

    <div class="card">
      <div class="card-caption">Service Account</div>

      <div>Account Number: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAcctNum" /></div>

      <div>Account Name: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAcctName" /></div>

      <div>Match existing account</div>
      <div>
        <SearchField />
      </div>

      <Acctx v-for="i in s.acctxs" :acctx="i" mode="0" />


      <div class="flex">
        <button @click="onClickNewAcctx">Add as a New Account</button>
        <div v-if="s.showAcctxAdded">New Account Added</div>
      </div>

    </div>

    <div class="card">
      <div class="card-caption">Billing</div>
      <div>Bill Date: </div>
      <div><input v-model="s.rep.data.bill.p.BillDate" /></div>

      <div>Amount: </div>
      <div><input v-model="s.rep.data.bill.p.Amt" /></div>
    </div>

    <div class="card">
      <div class="flex">
        <button @click="confirm">Confirm</button>
        the details and submit to our professional team.
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

import Unit from '~/comps/Unit.vue'
import Acctx from '~/comps/Acctx.vue'
import SearchField from '~/comps/SearchField.vue'
import StateLocator from '~/comps/StateLocator.vue'
import { router } from '~/lib/mod/route'

const s = glib.vue.reactive({
  fids: [],
  rep: {} as any,
  showUnitAdded: false,
  showAcctxAdded: false,
  units: [] as wyi.UNIT[],
  acctxs: [] as wyi.AcctComplex[],
  ucatproviders: [] as any,
  uproviders: [] as wyi.UPROVIDER[],
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {}, (rep: any) => {
    s.ucatproviders = []
    rep.data.forEach((e: any) => {
      s.ucatproviders.push({
        ucat: e.ucat as wyi.UCAT,
        uproviders: e.providers as wyi.UPROVIDER[]
      })
    });
  })

  try {
    let json = "" + sessionStorage.getItem('fids')
    s.fids = JSON.parse(json)
  } catch (e) {
  }

  sessionStorage.setItem('fids', JSON.stringify([]))

  Common.loader('my-units', {
    act: "ls"
  }, (rep: any) => {
    s.units = rep.data as wyi.UNIT[]
  })
  
  Common.loader('my-acctxs', {
    act: "ls"
  }, (rep: any) => {
    s.acctxs = rep.data as wyi.AcctComplex[]
  })
  
  Common.loader('/api/eu/review-bill-files', {
    fids: s.fids
  }, (rep: any) => {
    s.rep = rep
    console.log(s.rep)
    onChangeCat()
  })

})

const onClickNewUnit = () => {
  Common.loader('/api/eu/my-units', {
    data: {
      addr: s.rep.data.bill.p.ShownAddr,
      town: s.rep.data.bill.p.ShownTown,
      state: s.rep.data.bill.p.ShownState,
      zip: s.rep.data.bill.p.ShownZip
    },
    act: 'create'
  }, (rep: any) => {
    s.units.push(rep.data as wyi.UNIT)
    s.showUnitAdded = true
  })
}


const unit__text = (unit: wyi.UNIT) => {
  return unit.p.Address
    + ", " + unit.p.Town
    + ", " + unit.p.State
    + "" + unit.p.Zip
}

const onSelectUnit = (unit: wyi.UNIT) => {
  s.rep.data.bill.id = unit.id
  s.rep.data.bill.p.ShownAddr = unit.p.Address
  s.rep.data.bill.p.ShownTown = unit.p.Town
  s.rep.data.bill.p.ShownState = unit.p.State
  s.rep.data.bill.p.ShownZip = unit.p.Zip
}

const onChangeCat = () => {

  let found = s.ucatproviders.find((e: any) =>
    e.ucat.id == s.rep.data.bill.p.Cat)

  if (found)
    s.uproviders = found.uproviders
  else
    s.uproviders = []
}


const onClickNewAcctx = () => {
  Common.loader('/api/eu/my-acctxs', {
    data: {
      acctname: s.rep.data.bill.p.ShownAcctName,
      acctnum: s.rep.data.bill.p.ShownAcctNum
    },
    act: 'create'
  }, (rep: any) => {
    s.acctxs.push(rep.data as wyi.AcctComplex)
    s.showAcctxAdded = true
  })
}


const confirm = () => {
  Common.loader('/api/eu/submit-bill', {
    data: s.rep.data
  }, (rep: any) => {
    router.push("/")
  })
}

</script>