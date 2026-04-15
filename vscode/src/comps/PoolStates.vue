<template>

    <div class="flex">
      <PoolState :state="0" />
      <PoolState :state="1" />
      <PoolState :state="2" />
    </div>

</template>

<script setup lang="ts">

import PoolState from '~/comps/PoolState.vue'

</script>