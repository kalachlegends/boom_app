import { h, ref } from "vue"

export const useContextMenu = (items) => {
    const itemsContext = ref(items)
    const callContext = ref(() => console.error("CONTEXT NOT INSTALLED"))
    const handleContext = (callback) => {
        callContext.value = callback;
    }

    return {
        itemsContext,
        handleContext,
        callContext
    }
}

