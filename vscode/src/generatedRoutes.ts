import { RouteRecordRaw } from 'vue-router';


  const routes: Array<RouteRecordRaw> = [
    {
      path: '//Admin',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-Admin',
        component:()=> import("~/pages//Admin.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//Studio',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-Studio',
        component:()=> import("~/pages//Studio.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    }
  ];

  export default routes;
  