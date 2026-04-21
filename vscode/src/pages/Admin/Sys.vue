<template>

<div class="card">
  <div class="card-caption">
    Deploy
  </div>

  <div class="flex">

    <button @click="onClickClearData0()">
      Clear Business Data
    </button>

    <button @click="onClickClearData1()">
      Clear Business & Static Data
    </button>

  </div>

  <div>
    {{ s.msg }}
  </div>

</div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const s = glib.vue.reactive({
  msg: ""
})

const onClickClearData0 = () => {
  Common.loader('/api/admin/clear-data-0', {}, (rep: any) => {
    s.msg = "Business Data Cleared."
  })
}

const onClickClearData1 = () => {
  Common.loader('/api/admin/clear-data-1', {}, (rep: any) => {
    s.msg = "Business and Static Data Cleared."
  })
}

</script>