<template>

<h2>Review Bills</h2>

<div>
  Files: {{ s.fids }}
</div>

</template>


<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import BillFile from '~/comps/BillFile.vue'
import { FileComplex } from '~/comps/BillFile.vue'

const s = glib.vue.reactive({
  fids:[],
  rt: runtime
})


glib.vue.onMounted(async () => {

  try{
    let json = "" + sessionStorage.getItem('fids')
    s.fids =JSON.parse(json)
  } catch (e) {
  }

  sessionStorage.setItem('fids', JSON.stringify([]))

  Common.loader('/api/public/review-bills', {
    fids: s.fids
  },(rep:any) => {

  })

})


</script>