<template>

    <div class="card">
      
      <div v-if="props.title" class="card-caption">
        <router-link :to="'/m/' + s.mx.m.id">{{ s.mx.m.p.Title }}</router-link>
      </div>
      <div>
        {{ (new Date(s.mx.m.createdat)).toLocaleDateString() }}
        <button v-if="s.user.eu.p.AuthType == 2" @click="emits('edit',s.mx)" class="button-small">编辑</button>
      </div>
      <div v-if="props.summary" v-html="markdown__html(s.mx.m.p.Summary)" />
      <div v-if="props.preview">
        <img :src="s.mx.m.p.PreviewImgUrl" />
      </div>
      <div v-if="props.fulltext" v-html="markdown__html(s.mx.m.p.FullText)" />
      <div v-if="props.link" class="mt-5">
        <a :href="'https://fleaacademy.com/m/' + s.mx.m.id" target="_blank">{{ 'https://fleaacademy.com/m/' + s.mx.m.id }}</a>
      </div>
      <div class="mt-3"></div>
    </div>
    
    </template>

<script setup lang="ts">

import { getCurrentInstance, toRefs, watch } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'
import { upload,checkUrl }  from '~/lib/util/fetch'
import { decode } from '~/lib/util/text'
import { markdown__html } from '~/lib/util/markdown'

import UserAuth from '~/comps/UserAuth.vue'
import Uploader from '~/comps/Uploader.vue'
import RichTextEditor from '~/comps/RichTextEditor.vue'

const props = defineProps(['mx','id','title','summary','preview','fulltext','link'])
props.mx as fa.MomentComplex
props.id as number
props.title as boolean
props.summary as boolean
props.preview as boolean
props.fulltext as boolean
props.link as boolean

const s = glib.vue.reactive({
  user: runtime.user,
  mx: glib.Mor.fa.MomentComplex_empty()
})

const emits = defineEmits(['edit']) 

const reload = () => {
  if(props.mx)
    s.mx = props.mx
  else
    Common.loader('/api/public/moment', { id: Number(props.id) },(rep:any) => {
      s.mx = rep.data as fa.MomentComplex
      s.mx.m.p.FullText = decode(s.mx.m.p.FullText)
    })
}

watch(() => props.mx,(newValue, oldValue) => {
  s.mx = props.mx
  reload()
})

watch(() => props.id,(newValue, oldValue) => {
  reload()
})

glib.vue.onMounted(async () => {
  reload()
})

</script>