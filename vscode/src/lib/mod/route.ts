import { createMemoryHistory, createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

import Index from '~/pages/Studio.vue'

import Admin from '~/pages/Admin.vue'

const routes = [
  { path: '/', component: Index },
  { path: '/admin', component: Admin }
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
