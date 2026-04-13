<template>

  <span class="ml-[20px] px-2 inline-block">
    <img class="image-inline" :src="props.uprovider.p.Logo" />

    <span v-if="props.route">

      <router-link v-if="props.highlight"
        :to="routing()">
        <b class="selected">{{ props.uprovider.p.Caption }}</b>
      </router-link>
      <router-link v-else 
        :to="routing()">
        {{ props.uprovider.p.Caption }}
      </router-link>

      <span v-if="props.ucat">
        ({{ props.ucat.p.Caption }})
      </span>
    </span>

    <span v-else>
      <span v-if="props.highlight">
        <b class="selected">{{ props.uprovider.p.Caption }}</b>
      </span>
      <span v-else>
        {{ props.uprovider.p.Caption }}
      </span>

      <span v-if="props.ucat">
        ({{ props.ucat.p.Caption }})
      </span>
    </span>

  </span>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import { ref } from 'vue'

const props = defineProps(['ucat', 'uprovider', 'highlight', "route"])
props.ucat as wyi.UCAT
props.uprovider as wyi.UPROVIDER
props.highlight as boolean
props.route as string

const s = glib.vue.reactive({
  rt: runtime
})

const routing = () => {
  if (props.route) {
    let url = props.route + props.ucat.id + '/' + props.uprovider.id
    return url
  }
  else
    return props.route
}

</script>
