<template>

    <span class="ml-[20px] inline-block border-b border-gray-300">
        <img class="image-inline" :src="props.uprovider.p.Logo" />

        {{ props.uprovider.p.Caption }}

        <span v-if="props.ucat">
            ({{ props.ucat.p.Caption }})
        </span>
    </span>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import { ref } from 'vue'

const props = defineProps(['ucat', 'uprovider'])
props.ucat as wyi.UCAT
props.uprovider as wyi.UPROVIDER

</script
