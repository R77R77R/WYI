<template>

<div v-if="s.rt.user && s.rt.user.eu.id > 0" 
  class="flex items-center">
    <UserButton />
    <div>{{ s.rt.user.eu.p.Email }}</div>
    <div v-if="s.rt.user.eu.p.AuthType == 2" class="p-[15px]">
      <button @click="router.push('/Admin')">Admin Console</button>
    </div>
</div>
<div v-else class="flex items-center">
      <SignInButton asChild>
        <button class="px-2 py-1 bg-indigo-600 hover:bg-indigo-700 text-white rounded-sm shadow-md transition-all flex items-center gap-1">
          <i class="ri-login-box-line"></i>
          <span>Sign In</span>
        </button>
      </SignInButton>
      <div class="px-2">with</div>
      <img src="https://img.clerk.com/static/google.svg?width=160" />
      <!--SignUpButton /-->
</div>

</template>


<script setup lang="ts">

import { useUser, Show, SignInButton, SignUpButton, UserButton } from '@clerk/vue'

import { stringify } from 'postcss'
import { glib } from '~/lib/glib'
import { post } from '~/lib/util/fetch'
import { watch } from 'vue'
import * as Common from '~/lib/store/common'
import { router } from '~/lib/mod/route'

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
    } catch (err) {
      console.error('❌ 请求后端失败，请检查终端日志或 C# 断面:', err);
    }
  }
})

</script>

