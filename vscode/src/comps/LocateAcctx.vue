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
        :acctx="i" :mode="0" />
    </div>

    <div class="card-double-col-2"
      v-if="s.showDetails">

      <div class="form">

        <div>Provider</div>
        <div>
          <Provider :uprovider="props.uprovider" />
        </div>

        <div>Unit</div>
        <Unit :unit="props.unit" :mode="1" />

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
      <Acct :acctx="s.selected" :mode="1" />
      <button @click="s.showDetails = true">Reselect</button>
    </div>

  </div>

</template>


<script setup lang="ts">

import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import { watch } from 'vue'

import SearchField from '~/comps/SearchField.vue'
import Acctx from '~/comps/Acctx.vue'
import { AcctComplex_empty } from '~/lib/shared/CustomMor'
import Provider from './Provider.vue'
import Unit from './Unit.vue'

const props = defineProps(['api','acctx','ucat','uprovider','unit'])
props.api as string
props.acctx as wyi.AcctComplex
props.ucat as wyi.UCAT
props.uprovider as wyi.UPROVIDER
props.unit as wyi.UNIT

const s = glib.vue.reactive({
  showAdded: false,
  showDetails: true,
  items: [] as wyi.AcctComplex[],
  selected: AcctComplex_empty(),
  rt: runtime
})

watch(() => props.ucat,(newP, oldP) => {
  s.selected.cato = newP
})

watch(() => props.uprovider,(newP, oldP) => {
  s.selected.providero = newP
})

watch(() => props.unit,(newP, oldP) => {
  s.selected.unito = newP
})

glib.vue.onMounted(async () => {

  s.selected = props.acctx 
  if(props.ucat != null)
    s.selected.cato = props.ucat
  if(props.uprovider != null)
    s.selected.providero = props.uprovider
  if(props.unit != null)
    s.selected.unito = props.unit

  Common.loader(props.api, {
    act: "ls"
  }, (rep: any) => {
    s.items = rep.data as wyi.AcctComplex[]
  })
})

const onClickNew = () => {

  if(s.selected.unito != null)
    s.selected.acct.p.Unit = s.selected.unito.id
  if(s.selected.cato != null)
    s.selected.acct.p.Cat = s.selected.cato.id
  if(s.selected.providero != null)
    s.selected.acct.p.Provider = s.selected.providero.id

  Common.loader(props.api, {
    data: {
      unit: s.selected.acct.p.Unit,
      cat: s.selected.acct.p.Cat,
      provider: s.selected.acct.p.Provider,
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