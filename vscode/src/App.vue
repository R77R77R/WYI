<template> 


<header>
    <Show when="signed-out">
      <SignInButton />
      <SignUpButton />
    </Show>
    <Show when="signed-in">
      <UserButton />
    </Show>
</header>

<div>https://whatsyourideal.com/</div>
<div>Lower Your Bills On CruiseControl!</div>

<div class="lg:w-[1200px] mr-[10px]">

  <div class="main-color w-screen">

  <div class="flex justify-start">
    <UserAuth @changed="onAuthChanged" />
  </div>  

  <div class="w-full flex justify-center bg-[#262622]">
    <router-link to="/">Home</router-link>
    &nbsp;
  </div>

  <router-view />

  <div class="hor" />

  <div class="flex justify-center"><div class="hor-range">
    <div class="pt-2 pb-5">
      <br>© 2026 WYI
    </div>
  </div></div>

  </div>

</div>

</template>
  
<script setup>

import { useUser, Show, SignInButton, SignUpButton, UserButton } from '@clerk/vue'
import { post } from './lib/util/fetch' // 或者是你存放 fetch.ts 的具体路径
import { watch } from 'vue'

import { glib } from '~/lib/glib'
import { upload,checkUrl }  from '~/lib/util/fetch'

import UserAuth from '~/comps/UserAuth.vue'

const { isSignedIn, user } = useUser()

const s = glib.vue.reactive({
  rt: runtime
})

// 监听登录状态变化
// App.vue 调试代码
watch(isSignedIn, async (newVal) => {
  if (newVal === true) {
    console.log('🚀 登录成功，准备联调后端...');
    
    try {

      const payload = {
        clerkId: user.value.id,
        email: user.value.primaryEmailAddress?.emailAddress, // 获取 Gmail
        caption: user.value.fullName || user.value.username, // 获取姓名/昵称
        avatar: user.value.imageUrl                       // 可选：获取头像
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
  