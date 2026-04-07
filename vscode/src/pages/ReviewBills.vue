<template>

<h2>Review Bills</h2>

<div>
  Files: {{ s.files }}
</div>

</template>


<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'

import BillFile from '~/comps/BillFile.vue'
import { FileComplex } from '~/comps/BillFile.vue'

const s = glib.vue.reactive({
  files:[],
  rt: runtime
})


glib.vue.onMounted(async () => {
  s.files = history.state.files
})


</script>