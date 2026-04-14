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

    <div class="flex">
      <PoolState :state="0" />
      <PoolState :state="1" />
      <PoolState :state="2" />
    </div>

  </div>

  <div class="card" v-if="s.billxs.length > 0">
    <div class="card-caption">
      Bills
    </div>

    <div class="flex">
      <BillState :state="0" />
      <BillState :state="1" />
      <BillState :state="2" />
      <BillState :state="3" />
    </div>

    <Billx v-for="i in s.billxs" :billx="i" :mode="1" />

  </div>

</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'
import PoolState from '~/comps/PoolState.vue'
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