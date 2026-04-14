<template>

  <div class="card">
    <div class="card-caption" v-if="s.ucat.id > 0 && s.uprovider.id > 0">
      {{ s.uprovider.p.Caption }}
      ({{ s.ucat.p.Caption }})
    </div>
  </div>

  <div class="card">
    <div class="card-caption">
      Bill Pools
    </div>

    Draft//Draft///OnGoing//OnGoing///Closed//Closed

  </div>

  <div class="card" v-if="s.billxs.length > 0">
    <div class="card-caption">
      Bills
    </div>

    <div class="m-3">
      Bill States
    </div>
    <p>
      <BillState :state="0" />
      The user uploaded the files and submitted the bill for back office review.
    </p>
    <p>
      <BillState :state="1" />
      The officer review the bill and consider this bill is valid and eligible for negotiation.
    </p>
    <p>
      <BillState :state="2" />
      The bill has been added for a successful negotiation and the discount and commission are completely settled.
    </p>

    <Billx v-for="i in s.billxs" :billx="i" :mode="1" />

  </div>

</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'
import BillState from '~/comps/BillState.vue'
import Billx from '~/comps/Billx.vue'

const props = defineProps({
  cat: String,
  provider: String
})

const s = glib.vue.reactive({
  ucat: UCAT_empty(),
  uprovider: UPROVIDER_empty(),
  billxs: [] as wyi.BillComplex[],
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/admin/providers', {
    cat: props.cat,
    provider: props.provider,
    act: 'load'
  }, (rep: any) => {
    s.ucat = rep.cat
    s.uprovider = rep.provider,
      s.billxs = rep.billxs
  })

})

</script>