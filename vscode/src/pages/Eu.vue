<template>

  <div class="lg:w-[1200px] m-[10px]">

    <div class="main-color w-screen">

      <div class="w-full flex bg-[#9999ff] px-3 py-1 gap-5">
        <router-link to="/" class="text-white hover:text-gray-400">Home</router-link>
        <router-link v-if="check()" to="/eu/uploadBill" class="text-white hover:text-gray-400">
          Upload Bills</router-link>
        <router-link v-if="check()" to="/eu/MyBills" class="text-white hover:text-gray-400">
          My Bills</router-link>
        <router-link v-if="check()" to="/eu/myUnits" class="text-white hover:text-gray-400">
          My Units</router-link>
        <router-link v-if="check()" to="/eu/myAcctxs" class="text-white hover:text-gray-400">
          My Accounts</router-link>
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

const check = () => {
  if(s.rt.user == null)
    return false
  if(s.rt.user.eu.id == 0)
    return false
  else
    return true
}

</script>