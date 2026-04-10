<template> 

<div class="flex">

<UserAuth
  @changed="onAuthChanged" />

</div>

<div class="lg:w-[1200px] m-[10px]">

  <div class="main-color w-screen">

  <div class="w-full flex bg-[#9999ff] px-3 py-1 gap-5">
    <router-link to="/" class="text-white hover:text-gray-400">Home</router-link>
    <router-link to="/UploadBills" class="text-white hover:text-gray-400">Upload Bills</router-link>
  </div>

  <router-view class="m-h-[600px]" />

  <div class="hor" />

  <div class="flex justify-center"><div class="hor-range">
    <div class="pt-2 pb-5">
      <br>© 2026 WYI
    </div>
  </div></div>

  </div>

</div>

</template>
  
<script setup>

import { glib } from '~/lib/glib'

import UserAuth from '~/comps/UserAuth.vue'

const s = glib.vue.reactive({
  rt: runtime
})

</script>
  