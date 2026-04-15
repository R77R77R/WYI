<template>

  <div class="card">
    <div class="card-caption">
      My Units
    </div>
  </div>

  <Unit v-for="i in s.units" :unit="i" :mode="1" />

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import StateLocator from '~/comps/StateLocator.vue'
import Unit from '~/comps/Unit.vue'
import { pUNIT_empty } from '~/lib/shared/OrmMor'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  units: [] as wyi.UNIT[],
  toggleCreate: false,
  pUnit: pUNIT_empty(),
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/eu/my-units', {
    act: "ls"
  }, (rep: any) => {
    s.units = rep.data as wyi.UNIT[]
  })

})

</script>