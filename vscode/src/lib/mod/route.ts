import { createMemoryHistory, createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

import LayoutEu from '~/pages/Eu.vue'
import LayoutAdmin from '~/pages/Admin.vue'

const routes = [
  // EndUser 分支
  {
    path: '/eu',
    component: LayoutEu,
    children: [
      { path: 'home', component: () => import('~/pages/Eu/Home.vue') },
      { path: 'uploadBill', component: () => import('~/pages/Eu/UploadBill.vue') },
      { path: 'myUnits', component: () => import('~/pages/Eu/MyUnits.vue') },
      { path: 'myBills', component: () => import('~/pages/Eu/MyBills.vue') },
      { path: 'myAcctxs', component: () => import('~/pages/Eu/MyAcctxs.vue') },
    ]
  },

  // Admin 分支
  {
    path: '/admin',
    component: LayoutAdmin,
    children: [
      { path: 'home', component: () => import('~/pages/Admin/Home.vue') },
      { path: 'providers', component: () => import('~/pages/Admin/Providers.vue') },
      { path: 'provider/:cat/:provider', 
        component: () => import('~/pages/Admin/Provider.vue'),
        props: true },
      { path: 'bills', component: () => import('~/pages/Admin/Bills.vue') },
    ]
  },
  // 默认重定向
  { path: '/', redirect: '/eu/home' }
]

export const router = createRouter({
  history: createMemoryHistory(),
  routes
})


export const navigate = (href:string,name:string,id:number) => {

  let url = href

  if(url.indexOf('/zh/') > 0){
    runtime.lang = 'zh'
    localStorage.setItem("runtime.lang",runtime.lang)
    url = url.replace('/zh/','/')
  }
  if(url.indexOf('/en/') > 0){
    runtime.lang = 'en'
    localStorage.setItem("runtime.lang",runtime.lang)
    url = url.replace('/en/','/')
  }

  window.location.href = url
  if(id != 0)
    router.push({ name: name, params: { id: id } })
  else
    router.push(name)
}

const pages = [] as string[]

export const incomingRoute = () => {
  let path = window.location.pathname

  let hit = false
  pages.forEach((page:string) => {
    let pattern = "/" + page + "/"
    if(path.startsWith(pattern)){
      hit = true
      let id = path.substring(pattern.length)
      router.push({ name: page, params: { id: id }})
    }
  })

  if(hit == false){
    if(path.startsWith("/admin"))
      router.push('/admin')
    else
      router.push('/')
  }
}
