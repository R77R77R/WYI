<template> 

<header>
    <Show when="signed-out">
      <SignInButton />
      <SignUpButton />
    </Show>
    <Show when="signed-in">
      <UserButton />
    </Show>
  </header>

<div>MO Mar 23, 2026</div>
<div>Auto remote deploy</div>
<div>postgresql + F# + Kestrel + vue</div>
<div>https://whatsyourideal.com/</div>
<div>Lower Your Bills On CruiseControl!</div>

<div class="lg:w-[1200px] mr-[10px]">

  <div class="main-color w-screen">

  <div class="flex justify-start">
    <UserAuth @changed="onAuthChanged" />
  </div>  

  <div class="w-full flex justify-center bg-[#262622]">
    <img class="w-[300px] my-3" src="https://i.imgur.com/JvdrjQP.png">
  </div>

  <div class="flex justify-center p-3"><div class="flex hor-range">
    <div class="menu"><router-link to="/">Home</router-link></div>
    <div class="menu"><a href="#painting">Painting</a></div>
    <div class="menu"><a href="#price">Price</a></div>
    <div class="menu"><a href="#lesson">Lesson</a></div>
    <div class="bg-white">
      <a href="https://www.yelp.com/biz/sdcheen-fine-art-studio-dingmans-ferry" target="_blank">
        <img src="https://s3-media0.fl.yelpcdn.com/assets/srv0/yelp_design_cdn/7ef71bf77a33/assets/img/brand/logo_desktop.svg">
      </a>
    </div>
  </div>
</div>

  <router-view />

  <div class="hor" />

  <div class="flex justify-center"><div class="hor-range">
    <div class="pt-2 pb-5">
      <br>© 2025 CiteLand
    </div>
  </div></div>

  </div>

</div>

</template>
  
<script setup>

import { Show, SignInButton, SignUpButton, UserButton } from '@clerk/vue'

import { glib } from '~/lib/glib'
import { upload,checkUrl }  from '~/lib/util/fetch'

import UserAuth from '~/comps/UserAuth.vue'
  
</script>
  