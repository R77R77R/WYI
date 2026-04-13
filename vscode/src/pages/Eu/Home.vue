<template>

  <div class="card">
    <div>Production: <a href="https://whatsyourideal.com/" target="_blank">https://whatsyourideal.com/</a></div>
    <div>Demo: <a href="https://5.78.201.21/" target="_blank">https://5.78.201.21/</a></div>
    <div><a href="https://docs.google.com/document/d/1ST0W7PcwX-jppBmm4fPdORJHrkoe5yqgPvA7SfTSq0s/edit?usp=sharing" target="_blank">Google Doc</a></div>
  </div>
  <div class="card" v-if="s.rt.user != null && s.rt.user.eu.id > 0">
    <div class="card-caption">Upload and Review Your Bill</div>
    <div>
      <button @click="s.rt.router.push('/UploadBill')">GO</button>
    </div>
  </div>
  <div class="card" v-else>
    <div class="card-caption">Sign In and Review Your Bill</div>
    <div>
      <UserAuth />
    </div>
  </div>

  <ProviderList />

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import UserAuth from '~/comps/UserAuth.vue'
import ProviderList from '~/comps/ProviderList.vue'

import { ref } from 'vue'

const s = glib.vue.reactive({
  rt: runtime
})

</script>
