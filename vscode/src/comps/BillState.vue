<template>

  <span class="state-clickable bill-state-Submitted"
    v-if="props.state == 0">
    Submitted
  </span>
  <span class="state-clickable bill-state-Declined"
    v-else-if="props.state == 1">
    Declined
  </span>
  <span class="state-clickable bill-state-Accepted"
    v-else-if="props.state == 2">
    Accepted
  </span>
  <span class="state-clickable bill-state-Closed"
    v-else>
    Closed
  </span>

</template>


<script setup lang="ts">

const props = defineProps(['state'])
props.state as number

</script>