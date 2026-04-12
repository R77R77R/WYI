<template>

  <div class="card-double-col">

    <div class="card-double-col-span"
      v-if="s.showDetails">
      <div class="card-caption">Your Business/Residential Unit</div>
    </div>

    <div class="card-double-col-1"
      v-if="s.showDetails">

      <div>
        <SearchField 
          api="/api/eu/my-units" 
          :item__key="(i: wyi.UNIT) => i.id" 
          :item__text="item__text"
          @select="onSelect" />
      </div>

      <Unit class="card-clickable" 
        @click="onSelect(i)" 
        v-for="i in s.items" 
        :unit="i" :mode="0" />
    </div>

    <div class="card-double-col-2"
      v-if="s.showDetails">

      <div class="form">

        <div>Address: </div>
        <div><input v-model="s.selected.p.Address" /></div>

        <div>Town: </div>
        <div><input v-model="s.selected.p.Town" /></div>

        <div>State: </div>
        <StateLocator v-model="s.selected.p.State" />

        <div>ZIP: </div>
        <div><input v-model="s.selected.p.Zip" /></div>

      </div>

      <div class="flex">
        <button @click="onClickNew">Add as a New Unit</button>
        <div v-if="s.showAdded">New Unit Added</div>
      </div>

    </div>

    <div class="card-double-col-span" 
      v-if="s.selected.id > 0">
      <div class="card-caption">Selected Unit</div>
      <Unit :unit="s.selected" :mode="1" />
      <button @click="s.showDetails = true">Reselect</button>
    </div>

  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import { watch } from 'vue'

import SearchField from '~/comps/SearchField.vue'
import StateLocator from '~/comps/StateLocator.vue'
import Unit from '~/comps/Unit.vue'
import { UNIT_empty } from '~/lib/shared/OrmMor'

const props = defineProps(['api', 'unit'])
props.api as string
props.unit as wyi.UNIT

const s = glib.vue.reactive({
  showAdded: false,
  showDetails: true,
  items: [] as wyi.UNIT[],
  selected: UNIT_empty(),
  rt: runtime
})

glib.vue.onMounted(async () => {

  s.selected = props.unit 

  Common.loader(props.api, {
    act: "ls"
  }, (rep: any) => {
    s.items = rep.data as wyi.UNIT[]
  })
})

const onClickNew = () => {
  Common.loader(props.api, {
    data: {
      addr: s.selected.p.Address,
      town: s.selected.p.Town,
      state: s.selected.p.State,
      zip: s.selected.p.Zip
    },
    act: 'create'
  }, (rep: any) => {
    let item = rep.data as wyi.UNIT
    s.items.push(item)
    s.selected = item
    s.showAdded = true
  })
}

const item__text = (item: wyi.UNIT) => {
  return item.p.Address
    + ", " + item.p.Town
    + ", " + item.p.State
    + "" + item.p.Zip
}

const onSelect = (selected: wyi.UNIT) => {
  s.selected = selected
  if(s.selected.id > 0)
    s.showDetails = false
}


</script>