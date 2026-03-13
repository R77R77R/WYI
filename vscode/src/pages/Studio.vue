<template>

<div class="main-color lg:w-screen text-2xl">

<div class="hor" />

<div id="home" class="flex justify-center"><div class="hor-range">

<div class="text-5xl flex justify-center m-5">
  BE LOVED, BE PORTRAYED.
</div>

<div class="caption-1">Oil Painting</div>

<div class="lg:flex overflow-x-auto">
<img class="painting" src="https://i.imgur.com/lb9Venv.jpeg">
<img class="painting" src="https://i.imgur.com/YwSFX3r.jpeg">
<img class="painting" src="https://i.imgur.com/L2EL3Jq.jpeg">
</div>

<div class="caption-1">Sculpture and Egg Tempera</div>

<div class="lg:flex overflow-x-auto">
<img class="painting" src="https://i.imgur.com/dmkmNTJ.jpeg">
<img class="painting" src="https://i.imgur.com/YZDJVE7.jpeg">
<img class="painting" src="https://i.imgur.com/6DPeaUd.jpeg">
</div>

<div>
Oil painting by:
<br>Copy from photos: Book to send us photographs of yourself or your loved ones
<br>Live sittings: Experience a traditional portrait session, allowing for deeper capture of personality and character through direct observation.
Book a visit to my forest home studio in Dingmans Ferry, located near the scenic Delaware Water Gap National Recreation Area at the convergence of New York, New Jersey, and Pennsylvania.
</div>

<div id="book" class="my-5">
  <div>Contact by email: info@sdchen.art</div>
  <div v-if="s.expand == false">
    <button @click="s.expand = true">Book Now</button>
  </div>
  <div v-else class="m-3 p-3 bg-[#aabb99] w-[1000px]">
    <div>Name</div>
    <input v-model="s.name" type="text" class="w-[800px]"/>
    <div>Email</div>
    <input v-model="s.email" type="text" class="w-[800px]"/>
    <div>Message</div>
    <textarea v-model="s.msg" class="w-[800px] h-[500px]"></textarea>
    <button @click="submit">Submit</button>
  </div>
  <div>
    {{ s.prompt }}
  </div>
</div>

<div id="painting" class="caption-1">Painting Progress</div>

<div class="lg:flex justify-start">
<img class="painting" src="https://i.imgur.com/nMqz18N.jpeg">
<img class="painting" src="https://i.imgur.com/ypjl9oY.jpeg">
<img class="painting" src="https://i.imgur.com/at8cz1s.jpeg">
</div>

<div class="lg:flex justify-end">
<img class="painting" src="https://i.imgur.com/JaH5I2S.jpeg">
<img class="painting" src="https://i.imgur.com/65JdVrh.jpeg">
<img class="painting" src="https://i.imgur.com/uLdMbny.jpeg">
</div>

<div class="lg:flex justify-start">
<img class="painting" src="https://i.imgur.com/6bipccJ.jpeg">
<img class="painting" src="https://i.imgur.com/TSwr3Pw.jpeg">
<img class="painting" src="https://i.imgur.com/FygNW9w.jpeg">
</div>

<div class="lg:flex justify-end">
<img class="painting" src="https://i.imgur.com/mJkTKta.jpeg">  
<img class="painting" src="https://i.imgur.com/awNWKJf.jpeg">
<img class="painting" src="https://i.imgur.com/BNeLCuO.jpeg">
</div>

<div class="lg:flex justify-start">
<img class="painting" src="https://i.imgur.com/YAW4jVN.jpeg">
<img class="painting" src="https://i.imgur.com/ypiRqH5.jpeg">
<img class="painting" src="https://i.imgur.com/fTlsPsu.jpeg">
</div>

<div id="price" class="caption-1">Price</div>

<div>
Typically a 10" x 12" portrait is done in two sessions.
Each session lasts approx. 3 hours.
There is an intermission between the sessions to allow the oil to dry.

A portrait is $400 for the standard hourly rate of $65/hour plus the materials.

</div>

<div id="lesson" class="caption-1">Lesson</div>

<div>
  
<a href="#book">Book</a> portrait oil painting lessons.
<br>Master the art of oil portrait painting through private lessons. Available online or in-person.
<br>Session length: 3 hours
<br>Rate: $40/hour (plus tax)

</div>

</div></div>

<div class="hor" />

<div class="flex justify-center"><div class="hor-range">

<div>info@sdchen.art</div>
<div class="pt-2 pb-5">
133 KEYSTONE DR, DINGMANS FRY, PA 18328
<br>© 2024 COPYRIGHT SDCHEN FINE ART STUDIO
</div>

</div></div>

</div>

</template>
  

<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const s = glib.vue.reactive({
  name: "",
  email: "",
  msg: "",
  prompt: "",
  expand: false
})

const submit = async () => {

  Common.loader('/api/public/msg', { 
        name: s.name,
        email: s.email,
        msg: s.msg },(rep:any) => {
          s.expand = false
          s.prompt = "Your message has been sent."
        })
}

glib.vue.onMounted(async () => {
})

</script>




