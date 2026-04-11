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
      path: '//Bills',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-Bills',
        component:()=> import("~/pages//Bills.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//HomeCustomer',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-HomeCustomer',
        component:()=> import("~/pages//HomeCustomer.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//MyAcctxs',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-MyAcctxs',
        component:()=> import("~/pages//MyAcctxs.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//MyBills',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-MyBills',
        component:()=> import("~/pages//MyBills.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//MyUnits',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-MyUnits',
        component:()=> import("~/pages//MyUnits.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//ReviewBill',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-ReviewBill',
        component:()=> import("~/pages//ReviewBill.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    },
    {
      path: '//UploadBill',
      component: ()=>import ( "/src/layouts/blank.vue" ),
      meta: {"layout":"blank"},
      children: [{
        path: "",
        name: '-UploadBill',
        component:()=> import("~/pages//UploadBill.vue"),
        meta: {"layout":"blank"},
        props: true
      }]
    }
  ];

  export default routes;
  