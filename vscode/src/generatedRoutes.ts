import { RouteRecordRaw } from 'vue-router';


  const routes: Array<RouteRecordRaw> = [
    {
      path: '/Admin/Bills',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Admin-Bills',
        component:()=> import("~/pages/Admin/Bills.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Admin/Home',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Admin-Home',
        component:()=> import("~/pages/Admin/Home.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Admin/Provider',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Admin-Provider',
        component:()=> import("~/pages/Admin/Provider.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Admin/Providers',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Admin-Providers',
        component:()=> import("~/pages/Admin/Providers.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
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
      path: '/Eu/Home',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-Home',
        component:()=> import("~/pages/Eu/Home.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Eu/MyAcctxs',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-MyAcctxs',
        component:()=> import("~/pages/Eu/MyAcctxs.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Eu/MyBills',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-MyBills',
        component:()=> import("~/pages/Eu/MyBills.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Eu/MyUnits',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-MyUnits',
        component:()=> import("~/pages/Eu/MyUnits.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Eu/ReviewBill',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-ReviewBill',
        component:()=> import("~/pages/Eu/ReviewBill.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '/Eu/UploadBill',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: 'Eu-UploadBill',
        component:()=> import("~/pages/Eu/UploadBill.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//Eu',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-Eu',
        component:()=> import("~/pages//Eu.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    }
  ];

  export default routes;
  