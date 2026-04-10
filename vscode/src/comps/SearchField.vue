<template>

<div class="relative w-[200px]">
    
    <input 
      type="text" 
      v-model="searchText"
      @focus="isDropdownVisible = true"
      @blur="onBlur"
      @input="onInput"
      placeholder="Start typing..."
      class="w-full border rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
    />

    <ul 
      v-if="isDropdownVisible && s.opts.length > 0"
      class="absolute z-10 w-full bg-white border rounded shadow-lg mt-1 max-h-48 overflow-y-auto"
    >
      <li 
        v-for="opt in s.opts" 
        @click="selectOption(opt)"
        :value="props.item__key(opt)"
        class="px-3 py-2 hover:bg-blue-50 cursor-pointer text-sm"
      >
        {{ props.item__text(opt) }}
      </li>
    </ul>
  </div>

</template>

<script setup lang="ts">

import { ref, computed } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

const props = defineProps(['api','item__key','item__text'])
props.api as string
props.item__key as Function
props.item__text as Function

const s = glib.vue.reactive({
  opts: []
})

const emits = defineEmits(['select']) 

const searchText = ref('')
const isDropdownVisible = ref(false)

const onInput = () => {
  if (!searchText.value) return

  Common.loader(props.api, {
    term: searchText.value,
    act: "search"
  }, (rep: any) => {
    s.opts = rep.data
    console.log(s.opts)
  },() => {
  })
}

const selectOption = (opt: any) => {
  searchText.value = props.item__key(opt)
  isDropdownVisible.value = false

  emits('select',opt)
}

const onBlur = () => {
    setTimeout(() => isDropdownVisible.value = false, 200)    
}

</script>