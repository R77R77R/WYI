<template>

  <span class="pool-state-Draft"
    v-if="props.state == 0">
    Draft
  </span>
  <span class="pool-state-OnGoing"
    v-else-if="props.state == 1">
    On Going
  </span>
  <span class="pool-state-Closed"
    v-else>
    Closed
  </span>

</template>


<script setup lang="ts">

const props = defineProps(['state'])
props.state as number

</script>