<template>

<div>

<div class="flex">
  <div v-if="s.rt.user.eu.id > 0" class="p-[15px]">
    <UserButton />
    <div>{{ s.rt.user.eu.p.Email }}</div>
    <div v-if="s.rt.user.eu.p.AuthType == 2" class="p-[15px]">
      <router-link to="/Admin">Admin</router-link>
    </div>
  </div>
  <div v-else class="p-[15px]">
      <SignInButton /> via Google
      <!--SignUpButton /-->
  </div>
</div>

</div>

</template>


<script setup lang="ts">

import { useUser, Show, SignInButton, SignUpButton, UserButton } from '@clerk/vue'

import { stringify } from 'postcss'
import { glib } from '~/lib/glib'
import { post } from '~/lib/util/fetch'
import { watch } from 'vue'
import * as Common from '~/lib/store/common'

const { isSignedIn, user } = useUser()

const s = glib.vue.reactive({
  rt: runtime
})

const emits = defineEmits(['changed']) 

const signOut = () => {
  Common.loader('/api/public/auth', { act: 'sign-out' },(rep:any) => {
    runtime.user = glib.Mor.studio.EuComplex_empty()
    runtime.session = ""

    localStorage.setItem("runtime.user",JSON.stringify(runtime.user))
    localStorage.setItem("runtime.session",JSON.stringify(runtime.session))

    emits('changed',runtime.user,runtime.session)
  })
}

glib.vue.onMounted(async () => {

})


// 监听登录状态变化
// App.vue 调试代码
watch(isSignedIn, async (newVal) => {
  if (newVal === true) {
    console.log('🚀 登录成功，准备联调后端...');
    
    try {

      const payload = {
        clerkId: user?.value?.id,
        email: user?.value?.primaryEmailAddress?.emailAddress, // 获取 Gmail
        caption: user?.value?.fullName || user?.value?.username, // 获取姓名/昵称
        avatar: user?.value?.imageUrl                       // 可选：获取头像
      }

      // 1. 强制走 /api 前缀，确保触发 vite.config.ts 的 proxy
      // 2. 这里的 post 是你 fetch.ts 里的封装
      const response = await post("/api/public/auth",payload); 
      
      const { Er, session, eux } = response;
      if (Er === "OK"){
        s.rt.user = eux;
        s.rt.session = session;
      }
      
      console.log('✅ 后端响应成功:', response);
    } catch (err) {
      console.error('❌ 请求后端失败，请检查终端日志或 C# 断面:', err);
    }
  }
})

</script>

