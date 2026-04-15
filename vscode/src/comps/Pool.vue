<template>

<div class="caption">

  <PoolState :state="props.pool.p.State" />

  <div class="card-caption">
    Provider
  </div>

  <!--div v-if="props.poolx.cato && props.poolx.providero">
    <Provider :ucat="props.poolx.cato" :uprovider="props.poolx.providero" />
  </div>

  <div class="card-caption"
    v-if="props.poolx.manager.id > 0">
    Manager
  </div>
  <User v-if="props.poolx.manager.id > 0" :eu="props.poolx.manager" />

  <div class="card-caption">
    Bills
  </div>

  <Billx v-for="(k, v) in Object.entries(props.pool.bills)" :billx="v" />
-->
  
</div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import PoolState from '~/comps/PoolState.vue'
import Provider from '~/comps/Provider.vue'
import User from '~/comps/User.vue'
import Billx from '~/comps/Billx.vue'

const props = defineProps(['pool'])
props.pool as wyi.POOL

</script>