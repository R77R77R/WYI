<template>

    <div class="flex">
      <BillState :state="0" />
      <BillState :state="1" />
      <BillState :state="2" />
      <BillState :state="3" />
    </div>

</template>

<script setup lang="ts">

import BillState from '~/comps/BillState.vue'

</script>