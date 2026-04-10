<template>

  <h2>Review Bills</h2>

  <div v-for="fid in s.fids">
    <div class="w-[300px]">
      <img :src='"/thumbnail/" + fid' />
    </div>
  </div>


  <div v-if="s.rep.Er == 'OK'">

    <h2>Unit</h2>
    <div class="my-2 p-2 bg-[#eeeeff]">

      <div>Address: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAddr" /></div>
      
      <div>Town: </div>
      <div><input v-model="s.rep.data.bill.p.ShownTown" /></div>
      
      <div>State: </div>
      <div>
        <select v-model="s.rep.data.bill.p.ShownState">
          <option key="AL">AL Alabama</option>
          <option key="AK">AK Alaska</option>
          <option key="AZ">AZ Arizona</option>
          <option key="AR">AR Arkansas</option>
          <option key="CA">CA California</option>
          <option key="CO">CO Colorado</option>
          <option key="CT">CT Connecticut</option>
          <option key="DE">DE Delaware</option>
          <option key="FL">FL Florida</option>
          <option key="GA">GA Georgia</option>
          <option key="HI">HI Hawaii</option>
          <option key="ID">ID Idaho</option>
          <option key="IL">IL Illinois</option>
          <option key="IN">IN Indiana</option>
          <option key="IA">IA Iowa</option>
          <option key="KS">KS Kansas</option>
          <option key="KY">KY Kentucky</option>
          <option key="LA">LA Louisiana</option>
          <option key="ME">ME Maine</option>
          <option key="MD">MD Maryland</option>
          <option key="MA">MA Massachusetts</option>
          <option key="MI">MI Michigan</option>
          <option key="MN">MN Minnesota</option>
          <option key="MS">MS Mississippi</option>
          <option key="MO">MO Missouri</option>
          <option key="MT">MT Montana</option>
          <option key="NE">NE Nebraska</option>
          <option key="NV">NV Nevada</option>
          <option key="NH">NH New Hampshire</option>
          <option key="NJ">NJ New Jersey</option>
          <option key="NM">NM New Mexico</option>
          <option key="NY">NY New York</option>
          <option key="NC">NC North Carolina</option>
          <option key="ND">ND North Dakota</option>
          <option key="OH">OH Ohio</option>
          <option key="OK">OK Oklahoma</option>
          <option key="OR">OR Oregon</option>
          <option key="PA">PA Pennsylvania</option>
          <option key="RI">RI Rhode Island</option>
          <option key="SC">SC South Carolina</option>
          <option key="SD">SD South Dakota</option>
          <option key="TN">TN Tennessee</option>
          <option key="TX">TX Texas</option>
          <option key="UT">UT Utah</option>
          <option key="VT">VT Vermont</option>
          <option key="VA">VA Virginia</option>
          <option key="WA">WA Washington</option>
          <option key="WV">WV West Virginia</option>
          <option key="WI">WI Wisconsin</option>
          <option key="WY">WY Wyoming</option>
        </select>
      </div>
      
      <div>ZIP: </div>
      <div><input v-model="s.rep.data.bill.p.ShownZip" /></div>
    
      <div>Match existing unit</div>
      <div>
        <SearchField />
      </div>

      <div><button>Add as a New Unit</button></div>

    </div>
    
    <h2>Provider</h2>
    <div class="my-2 p-2 bg-[#eeeeff]">
      <div>Category</div>
      <!--div>
        <select v-model="s.rep.data.cato">
          <option v-for="item in s.ucatproviders" :key="(item.ucat as wyi.UCAT).id">
            {{ (item.ucat as wyi.UCAT).p.Caption }}
          </option>
        </select>
      </div>
      
      <div>Provider: {{ s.rep.data.Provider }}</div>
      <div>
        <select>
          <option
            v-for="item in s.ucatproviders.find((e: any) => e.ucat.id == s.rep.data.CategoryID).uproviders as wyi.UPROVIDER[]"
            :key="(item as wyi.UPROVIDER).id">
            {{ item.p.Caption }}
          </option>
        </select>
      </div-->
      
      <div>
        <input v-model="s.rep.data.bill.p.ShownProvider" />
        <div>
          <select>
          </select>
        </div>
        <div>Matched. Within our scope of service.</div>
      </div>
    </div>

    <h2>Account</h2>
    <div class="my-2 p-2 bg-[#eeeeff]">

      <div>Account Number: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAcctNum" /></div>
      
      <div>Account Name: </div>
      <div><input v-model="s.rep.data.bill.p.ShownAcctName" /></div>
    
      <div>Match existing account</div>
      <div>
        <SearchField />
      </div>

      <div><button>Add New Account</button></div>

    </div>

    <div>Bill Data: </div>
    <div><input v-model="s.rep.data.bill.p.BillDate" /></div>
    
    <div>Amount: </div>
    <div><input v-model="s.rep.data.bill.p.Amt" /></div>

    <div class="flex">
      <button @click="confirm">Confirm</button>
      the details and submit to our professional team.
    </div>

  </div>
  <div v-else-if="s.rep.Er == 'API3rdParty'">
    We experienced an issue from the AI.
    You can try later: {{ s.rep.msg }}
  </div>
  <div v-else>AI processing ... 20 seconds expected</div>

  <div>{{ s.rep }}</div>
</template>


<script setup lang="ts">
import { ref } from 'vue'
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import BillFile from '~/comps/BillFile.vue'
import { FileComplex } from '~/comps/BillFile.vue'
import SearchField from '~/comps/SearchField.vue'
import { router } from '~/lib/mod/route'

const s = glib.vue.reactive({
  fids: [],
  rep: {} as any,
  ucatproviders: [] as any,
  rt: runtime
})


glib.vue.onMounted(async () => {

  Common.loader('/api/public/providers', {}, (rep: any) => {
    s.ucatproviders = []
    rep.data.forEach((e: any) => {
      s.ucatproviders.push({
        ucat: e.ucat as wyi.UCAT,
        uproviders: e.providers as wyi.UPROVIDER[]
      })
    });
  })

  try {
    let json = "" + sessionStorage.getItem('fids')
    s.fids = JSON.parse(json)
  } catch (e) {
  }

  sessionStorage.setItem('fids', JSON.stringify([]))

  Common.loader('/api/eu/review-bill-files', {
    fids: s.fids
  }, (rep: any) => {
    s.rep = rep
    console.log(s.rep)
  })

})

const confirm = () => {
    Common.loader('/api/eu/submit-bill', { 
      data: s.rep.data
    },(rep:any) => {
      if(rep.Er == "OK"){
        router.push("/")
      }
    })
}

</script>