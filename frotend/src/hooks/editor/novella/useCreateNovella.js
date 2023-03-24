import { useStore } from "vuex"
import { computed } from "vue"
import { useRouter } from "vue-router"

export const createNewNovella = () => {
    const store = useStore()
    const router = useRouter()
    const handleNewNovella = async (type_novella, img_url) => {
        await store.dispatch("createNewNovella", {
            type_novella,
            img_url
        })

        router.push({
            name: 'editor_tree_novella',
            params: {
                novella_id: store.state.novella.novella.id
            }
        })
    }
    return {
        handleNewNovella,
        novella: computed(() => store.state.novella.novella)
    }
}