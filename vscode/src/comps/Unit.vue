<template>

<div class="card">

<div v-if="props.mode == 0">
  {{ props.unit.p.Address }}
  {{ props.unit.p.Town }}
  {{ props.unit.p.State }}
  {{ props.unit.p.Zip }}
</div>

<div v-if="props.mode == 1">
  <div>
    {{ props.unit.p.Address }}
  </div>
  
  <div>
    {{ props.unit.p.Town }}
  </div>

  <div>
    {{ props.unit.p.State }}
    {{ props.unit.p.Zip }}
  </div>
  
</div>

</div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const props = defineProps(['unit','mode'])
props.unit as wyi.UNIT
props.mode as number

const s = glib.vue.reactive({
  rt: runtime
})

glib.vue.onMounted(async () => {

})

</script>
