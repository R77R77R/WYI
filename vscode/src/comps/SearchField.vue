<template>

<div class="relative w-64">
    
    <input 
      type="text" 
      v-model="searchText"
      @focus="isDropdownVisible = true"
      @blur="onBlur"
      placeholder="Start typing..."
      class="w-full border rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
    />

    <ul 
      v-if="isDropdownVisible && filteredOptions.length > 0"
      class="absolute z-10 w-full bg-white border rounded shadow-lg mt-1 max-h-48 overflow-y-auto"
    >
      <li 
        v-for="opt in filteredOptions" 
        :key="opt.id"
        @click="selectOption(opt.name)"
        class="px-3 py-2 hover:bg-blue-50 cursor-pointer text-sm"
      >
        {{ opt.name }}
      </li>
    </ul>
  </div>

</template>

<script setup lang="ts">

import { ref, computed } from 'vue'

// 模拟从数据库或本地获取的 Provider 列表
const providers = ref([
  { id: 1, name: 'T-Mobile' },
  { id: 2, name: 'Spectrum' },
  { id: 3, name: 'Insurance Co' },
  { id: 4, name: 'Water Board' }
])

const searchText = ref('')
const isDropdownVisible = ref(false)

// 关键逻辑：Text Changed 触发的模糊匹配
const filteredOptions = computed(() => {
  if (!searchText.value) return []
  return providers.value.filter(p => 
    p.name.toLowerCase().includes(searchText.value.toLowerCase())
  )
})

const selectOption = (name: string) => {
  searchText.value = name
  isDropdownVisible.value = false
}

const onBlur = () => {
    setTimeout(() => isDropdownVisible.value = false, 200)    
}

</script>