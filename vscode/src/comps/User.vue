<template>

  <span class="eu-AuthType-Admin" 
  v-if="props.eu.p.AuthType == 2">
    Admin
  </span>

  <span v-if="props.eu.p.OAuthProvider != ''">
    {{ props.eu.p.Email }}
    <img class="img-oauth" :src="'https://img.clerk.com/static/' + eu.p.OAuthProvider + '.svg'" />
  </span>

  <span>
    {{ props.eu.p.Username }}
  </span>


</template>


<script setup lang="ts">

import Provider from '~/comps/Provider.vue';
import { glib } from '~/lib/glib'

const props = defineProps(['eu'])
props.eu as wyi.EU

</script>