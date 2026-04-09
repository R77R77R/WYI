<template>

  <h2>Review Bills</h2>

  <div v-for="fid in s.fids">
    <div class="w-[300px]">
      <img :src='"/thumbnail/" + fid' />
    </div>
  </div>


  <div v-if="s.rep.Er == 'OK'">
    
    <div>Category: {{ s.rep.data.Category }}</div>
    <div>
      <select v-model="s.rep.data.CategoryID">
        <option v-for="item in s.ucatproviders" :key="(item.ucat as wyi.UCAT).id">
          {{ (item.ucat as wyi.UCAT).p.Caption }}
        </option>
      </select>
    </div>
    
    <div>Provider: {{ s.rep.data.Provider }}</div>
    <div>
      <select>
        <option
          v-for="item in s.ucatproviders.find((e: any) => e.ucat.id == s.rep.data.CategoryID).uproviders as wyi.UPROVIDER[]"
          :key="(item as wyi.UPROVIDER).id">
          {{ item.p.Caption }}
        </option>
      </select>
    </div>
    
    <div>Provider: </div>
    <div><input v-model="s.rep.data.Provider" /></div>
    
    <div>Account Number: </div>
    <div><input v-model="s.rep.data.AcctNum" /></div>
    
    <div>Account Name: </div>
    <div><input v-model="s.rep.data.AcctName" /></div>
    
    <div>Address: </div>
    <div><input v-model="s.rep.data.Addr" /></div>
    
    <div>Town: </div>
    <div><input v-model="s.rep.data.Town" /></div>
    
    <div>State: </div>
    <div><input v-model="s.rep.data.State" /></div>
    
    <div>ZIP: </div>
    <div><input v-model="s.rep.data.ZIP" /></div>
    
    <div>Bill Data: </div>
    <div><input v-model="s.rep.data.BillDate" /></div>
    
    <div>Amount: </div>
    <div><input v-model="s.rep.data.Amt" /></div>

    <div class="flex">
      <button @click="confirm">Confirm</button>
      the details and submit to our professional team.
    </div>

  </div>
  <div v-else-if="s.rep.Er == 'API3rdParty'">
    {{ s.rep.msg }}
  </div>
  <div v-else>Waiting for AI processing ... 20 seconds </div>

</template>


<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import BillFile from '~/comps/BillFile.vue'
import { FileComplex } from '~/comps/BillFile.vue'
import { router } from '~/lib/mod/route'

const s = glib.vue.reactive({
  fids: [],
  rep: {} as any,
  ucatproviders: [] as any,
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

  Common.loader('/api/eu/review-bill-files', {
    fids: s.fids
  }, (rep: any) => {
    s.rep = rep
    if (s.rep.Er == "API3rdParty") {
      s.rep.msg = rep.Msg
    }
    if (s.rep.Er == "OK") {
      s.rep.data = rep.data
    }
  })

})

const confirm = () => {
    Common.loader('/api/eu/submit-bill', { 
      data: s.rep.data
    },(rep:any) => {
      if(rep.Er == "OK"){
        router.push("/")
      }
    })
}

</script>