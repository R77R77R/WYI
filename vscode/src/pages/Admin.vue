<template>

  <div class="lg:w-[1200px] m-[10px]">

    <div class="main-color w-screen">

      <div class="w-full flex bg-[#ffcc99] px-3 py-1 gap-5">
        
        <router-link to="/eu/home" 
          class="bg-white px-2 text-[#ffcc99] hover:text-gray-400">
          User View
        </router-link>

        <router-link to="/" class="text-white hover:text-gray-400">
          Home
        </router-link>
        
        <router-link to="/admin/providers" class="text-white hover:text-gray-400">
          Providers
        </router-link>
 
        <router-link to="/admin/bills" class="text-white hover:text-gray-400">
          Bills
        </router-link>
 
        <router-link to="/admin/sys" class="text-white hover:text-gray-400">
          System
        </router-link>

      </div>

      <router-view class="min-h-[600px]" />

    </div>

  </div>

</template>


<script setup>

import { glib } from '~/lib/glib'

import UserAuth from '~/comps/UserAuth.vue'

const s = glib.vue.reactive({
  rt: runtime
})

glib.vue.onMounted(async () => {
  if(s.rt.user == null)
    s.rt.router.push('/')
  if(s.rt.user.eu.id == 0)
    s.rt.router.push('/')
  if(s.rt.user.eu.p.AuthType != 2)
    s.rt.router.push('/')
})

</script>