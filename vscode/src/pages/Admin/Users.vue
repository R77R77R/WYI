<template>

  <div class="card">
    <div class="card-caption">Users</div>
    <div>
      <SearchField api="/api/admin/users" :item__key="(eu: wyi.EU) => eu.id"
        :item__text='(eu: wyi.EU) => eu.p.Caption + " " + eu.p.Username + " " + eu.p.Email' @select="onSelectUser" />
    </div>
    <div v-for="i in s.eus">
      <User :eu="i" />
    </div>
  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'
import User from '~/comps/User.vue'

const s = glib.vue.reactive({
  eus: [] as wyi.EU[],
  rt: runtime
})

const onSelectUser = (eu: wyi.EU) => {
}

glib.vue.onMounted(async () => {

  Common.loader('/api/admin/users', {
    act: "ls"
  }, (rep: any) => {
    s.eus = rep.data as wyi.EU[]
  })

})

</script>