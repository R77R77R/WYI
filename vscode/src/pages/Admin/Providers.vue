<template>

 <ProviderList :route="'/admin/provider/'" />

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import ProviderList from '~/comps/ProviderList.vue'

</script>