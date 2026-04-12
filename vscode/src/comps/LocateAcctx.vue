<template>

  <div class="card-double-col">

    <div class="card-double-col-span"
      v-if="s.showDetails">
      <div class="card-caption">Your Service Account</div>
    </div>

    <div class="card-double-col-1"
      v-if="s.showDetails">

      <div>
        <SearchField 
          api="/api/eu/my-acctx" 
          :item__key="(i: wyi.AcctComplex) => i.acct.id" 
          :item__text="item__text"
          @select="onSelect" />
      </div>

      <Acctx class="card-clickable" 
        @click="onSelect(i)" 
        v-for="i in s.items" 
        :unit="i" :mode="0" />
    </div>

    <div class="card-double-col-2"
      v-if="s.showDetails">

      <div class="form">

        <div>Account Number: </div>
        <div><input v-model="s.selected.acct.p.AcctNum" /></div>

        <div>Account Name: </div>
        <div><input v-model="s.selected.acct.p.AcctName" /></div>

      </div>

      <div class="flex">
        <button @click="onClickNew">Add as a New Account</button>
        <div v-if="s.showAdded">New Account Added</div>
      </div>

    </div>

    <div class="card-double-col-span" 
      v-if="s.selected.acct.id > 0">
      <div class="card-caption">Selected Account</div>
      <Unit :unit="s.selected" :mode="1" />
      <button @click="s.showDetails = true">Reselect</button>
    </div>

  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import SearchField from '~/comps/SearchField.vue'
import StateLocator from '~/comps/StateLocator.vue'
import Acctx from '~/comps/Acctx.vue'
import { AcctComplex_empty } from '~/lib/shared/CustomMor'

const props = defineProps(['api', 'acctx'])
props.api as string
props.acctx as wyi.AcctComplex

const s = glib.vue.reactive({
  showAdded: false,
  showDetails: true,
  items: [] as wyi.AcctComplex[],
  selected: AcctComplex_empty(),
  rt: runtime
})

glib.vue.onMounted(async () => {

  s.selected = props.acctx 

  Common.loader(props.api, {
    act: "ls"
  }, (rep: any) => {
    s.items = rep.data as wyi.AcctComplex[]
  })
})

const onClickNew = () => {
  Common.loader(props.api, {
    data: {
      //unit: s.selected,
//      cat: s.rep.data.bill.p.Cat,
//      provider: s.rep.data.bill.p.Provider,
      acctname: s.selected.acct.p.AcctName,
      acctnum: s.selected.acct.p.AcctNum
    },
    act: 'create'
  }, (rep: any) => {
    let item = rep.data as wyi.AcctComplex
    s.items.push(item)
    s.selected = item
    s.showAdded = true
  })
}

const item__text = (item: wyi.AcctComplex) => {
  return item.acct.p.AcctName
    + " " + item.acct.p.AcctNum
}

const onSelect = (selected: wyi.AcctComplex) => {
  s.selected = selected
  if(s.selected.acct.id > 0)
    s.showDetails = false
}


</script>