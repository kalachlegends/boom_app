<template lang="">
    <div class="tw-flex tw-gap-3 tw-justify-between tw-min-h-full tw-h-full">
        <n-card title="Неактивные" size="medium" @dragenter="onDragEnter('passive')"   @dragend="onDragEnd"  class="tw-h-full tw-gap-3 tw-flex tw-flex-col">
        <Card    
      
        :objectCard="item " v-for="item in incidentListPassive"
        draggable="true"
        @drag="onDragStart(item)"
        />
           
        </n-card>
        <n-card @dragenter="onDragEnter('active')" @dragend="onDragEnd"  title="Активные" size="medium" class="tw-h-full"> 
            <Card    
            draggable="true"
            :objectCard="item " v-for="item in incidentListActive"
            @drag="onDragStart(item)"
            
             />
               
        </n-card>
        <n-card title="Готовые" size="medium" class="tw-h-full"> 

        </n-card>
        <n-card title="Удалённые" size="medium" class="tw-h-full"> 
            
        </n-card>
      </div>
</template>
<script setup>
import { computed, onMounted, ref } from "vue";
import { axios } from "src/boot/axios";
import Card from "./Card.vue";
const itemDrag = ref({});
const inscidentList = ref([]);
const incidentListPassive = computed(() =>
  inscidentList.value.filter((el) => el.status == "passive")
);
const type = ref("passvie");
const incidentListActive = computed(() =>
  inscidentList.value.filter((el) => el.status == "active")
);
onMounted(async () => {
  const { data } = await axios.get("/incident/all");
  console.log(data);
  inscidentList.value = data.incident;
});

const onDragStart = (item) => {
  console.log();
  itemDrag.value = item;
};
const onDragEnd = () => {
  console.log(type);
  const item = inscidentList.value.find((el) => el.id == itemDrag.value.id);

  item.status = type.value;
};
const onDragEnter = (typeREf) => {
  type.value = typeREf;
};
</script>
<style  lang="scss">
.n-card > .n-card__content {
  flex: 1;
  display: flex;
  gap: 10px;
  min-width: 0;
  flex-direction: column;
}
</style>