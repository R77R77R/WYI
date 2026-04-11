<template>

  <div class="flex justify-center">
    <div class="hor-range">

      <div class="card">
        <div class="card-caption">Users</div>
 
              <div>
        <SearchField
          api="/api/admin/users"
          :item__key="user__key"
          :item__text="user__text"
          @select="onSelectUser" />
      </div>

 
        <div v-for="i in s.users">
          {{ i.p.Email }}
        </div>
      </div>


    </div>
  </div>

  <div class="flex justify-center">
    <div class="hor-range">




    </div>
  </div>

</template>

<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import SearchField from '~/comps/SearchField.vue'

const s = glib.vue.reactive({
  users: [] as wyi.EU[],
  rt: runtime
})


const user__key = (eu:wyi.EU) => {
  return eu.id
}

const user__text = (eu:wyi.EU) => {
  return eu.p.Address 
    + ", " + eu.p.Town
    + ", " + eu.p.State
    + "" + eu.p.Zip
}

const onSelectUser = (eu:wyi.EU) => {
}


glib.vue.onMounted(async () => {

  Common.loader('/api/admin/users', {
    act: "ls"
  }, (rep: any) => {
    s.users = rep.data as wyi.EU[]
  })

})

</script>