<template>

  <span class="bill-state-Submitted"
    v-if="props.state == 0">
    Submitted
  </span>
  <span class="bill-state-Accepted"
    v-else-if="props.state == 1">
    Accepted
  </span>
  <span class="bill-state-Closed"
    v-else>
    Closed
  </span>

</template>


<script setup lang="ts">

const props = defineProps(['state'])
props.state as number

</script>