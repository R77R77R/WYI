<template> 

<div>https://whatsyourideal.com/</div>
<div>Lower Your Bills On CruiseControl!</div>

<div class="lg:w-[1200px] mr-[10px]">

  <div class="main-color w-screen">

  <div class="flex justify-start">
    <UserAuth @changed="onAuthChanged" />
  </div>  

  <div class="w-full flex justify-center bg-[#262622]">
    <router-link to="/">Home</router-link>
    &nbsp;
  </div>

  <router-view />

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
  