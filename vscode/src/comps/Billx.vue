<template>

  <div class="card">

    <div class="flex" v-if="props.mode == 0">

      <div>
        <BillState :state="props.billx.bill.p.State" />
      </div>

      <div>
        <div v-if="props.billx.cato && props.billx.providero">
          <Provider :ucat="props.billx.cato" :uprovider="props.billx.providero" />
        </div>

        <Unit v-if="props.billx.unito" :unit="props.billx.unito" />

        <Acctx v-if="props.billx.acctxo" :acctx="props.billx.acctxo" />

        <div v-if="props.billx.cato && props.billx.providero">
          Amount: ${{ props.billx.bill.p.Amt }}
        </div>
      </div>

    </div>

    <div v-if="props.mode == 1">

      <div class="flex">
        <BillState :state="props.billx.bill.p.State" />
        <button class="button-small">Accept</button>
      </div>

      <div>

        <div class="card-caption" v-if="props.billx.cato && props.billx.providero">
          Bill Details
        </div>
        <div v-if="props.billx.cato && props.billx.providero">
          <Provider :ucat="props.billx.cato" :uprovider="props.billx.providero" />
        </div>

        <div class="card-caption" v-if="props.billx.unito">
          Unit
        </div>
        <Unit v-if="props.billx.unito" :unit="props.billx.unito" :mode="1" />

        <div class="card-caption" v-if="props.billx.acctxo">
          Acct
        </div>
        <Acctx v-if="props.billx.acctxo" :acctx="props.billx.acctxo" :mode="1" />

        <div class="card-caption">
          Billing Info
        </div>
        <div>
          Bill Date: ${{ props.billx.bill.p.YYYYMMDD }}
        </div>
        <div>
          Amount: ${{ props.billx.bill.p.Amt }}
        </div>
      </div>

      <div class="card-caption">
        Files
      </div>
      <div class="flex">
        <a target="_blank" v-for="i in props.billx.files" :href="'/file/' + i.id">
          <img :src="'/thumbnail/' + i.id" />
        </a>
      </div>

    </div>

  </div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import BillState from '~/comps/BillState.vue'
import Provider from '~/comps/Provider.vue'
import Unit from '~/comps/Unit.vue'
import Acctx from '~/comps/Acctx.vue'

const props = defineProps(['billx', 'mode'])
props.billx as wyi.BillComplex
props.mode as number

const s = glib.vue.reactive({
  rt: runtime
})

glib.vue.onMounted(async () => {

})

</script>
