<template>

<div class="card">

  <div class="card-caption">
    {{ props.provider }}
  </div>

</div>

</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'
import { UCAT_empty, UPROVIDER_empty } from '~/lib/shared/OrmMor';
import * as Common from '~/lib/store/common'

const props = defineProps({
  cat: String,
  provider: String
})

const s = glib.vue.reactive({
  ucat: UCAT_empty(),
  uprovider: UPROVIDER_empty(),
  rt: runtime
})

glib.vue.onMounted(async () => {

  Common.loader('/api/admin/providers', {
    cat: props.cat,
    provider: props.provider,
    act: 'load'
  }, (rep: any) => {
    
  })

})

</script>