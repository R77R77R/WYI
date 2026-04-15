<template>

{{ props.pool }}

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import PoolState from '~/comps/PoolState.vue'
import Provider from '~/comps/Provider.vue'

const props = defineProps(['pool'])
props.pool as wyi.POOL

</script>