<template>

<div>Upload Bills</div>

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




