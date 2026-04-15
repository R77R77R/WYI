<template>

  <div class="card">
    <div class="card-caption">
      Demo Summary
    </div>
    <div>Current Website: <a href="https://whatsyourideal.com/" target="_blank">https://whatsyourideal.com/</a></div>
    <div>Demo: <a href="https://5.78.201.21/" target="_blank">https://5.78.201.21/</a></div>
    <div>
      Documentation:
      <a href="https://docs.google.com/document/d/1ST0W7PcwX-jppBmm4fPdORJHrkoe5yqgPvA7SfTSq0s/edit?usp=sharing" target="_blank">
        Run through the demo
      </a>
      | <a href="https://docs.google.com/spreadsheets/d/1rkHsUWFX-SugM9SB1gLJkAjO8h9c9DkfOzWGyKeG4DE/edit?usp=sharing" target="_blank">
        Trace issues
      </a>
    </div>
    <div>
      Clerk SSO:
      <a href="https://clerk.com/docs/guides/configure/auth-strategies/social-connections/overview" target="_blank">
        Supported social providers
      </a>
      | <a href="https://dashboard.clerk.com/apps/app_3BUWqG9rLal8U7qrP2MCA4jEvFX/instances/ins_3BUWqB8zkyGOBoUQ9BfsugqEBAv/user-authentication/sso-connections" target="_blank">
        Config
      </a>
    </div>
    <div>
      Gemini AI:
      <a href="https://aistudio.google.com/app/projects" target="_blank">
        API key
      </a>
      | <a href="https://aistudio.google.com/app/billing?billing=0162F4-BB3466-5E8B6E" target="_blank">
        Billing
      </a>
    </div>
    <div>
      Updated: Apr 14, 2026
    </div>
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
