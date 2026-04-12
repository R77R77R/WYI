<template>

    <span class="ml-[20px] px-2 inline-block">
        <img class="image-inline" :src="props.uprovider.p.Logo" />

        <span v-if="props.highlight">
            <b class="selected">{{ props.uprovider.p.Caption }}</b>
        </span>
        <span v-else>
            {{ props.uprovider.p.Caption }}
        </span>

        <span v-if="props.ucat">
            ({{ props.ucat.p.Caption }})
        </span>
    </span>

</template>

<script setup lang="ts">
import { glib } from '~/lib/glib'
import * as Common from '~/lib/store/common'

import { ref } from 'vue'

const props = defineProps(['ucat', 'uprovider', 'highlight'])
props.ucat as wyi.UCAT
props.uprovider as wyi.UPROVIDER
props.highlight as boolean

</script>
