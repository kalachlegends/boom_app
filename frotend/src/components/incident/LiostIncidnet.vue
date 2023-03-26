<template lang="">
  <div class="tw-flex tw-justify-between">
    <n-statistic label="Всего задач">
      {{inscidentList.length}}
    </n-statistic>
    <n-statistic label="Сделано">
      {{incidentListCompleted.length}}
    </n-statistic>

  </div>
    <div class="tw-flex tw-gap-3 tw-justify-between tw-min-h-full tw-h-full">
      <n-card  title="Бек Лог">
        <Card    
          
        :objectCard="item " v-for="item in incidentBackLog"
        :draggable="canDrag(item)"
        @click="handleShow(item)"
        @drag="onDragStart(item)"
        @dragend="onDragEnd"
        />
           
      </n-card>

        <n-card title="Неактивные" size="medium" @dragenter="onDragEnter('passive')"     class="tw-h-full tw-gap-3 tw-flex tw-flex-col">
        <Card    
          
        :objectCard="item " v-for="item in incidentListPassive"
        :draggable="canDrag(item)"
        @click="handleShow(item)"
        @drag="onDragStart(item)"
        @dragend="onDragEnd"
        />
           
        </n-card>
        <n-card @dragenter="onDragEnter('active')"  title="Активные" size="medium" class="tw-h-full"> 
            <Card    
            :draggable="canDrag(item)"
            :objectCard="item " v-for="item in incidentListActive"
            @drag="onDragStart(item)"
            @click="handleShow(item)"
            @dragend="onDragEnd"
             />
               
        </n-card>
        <n-card @dragenter="onDragEnter('completed')" title="Готовые" size="medium" class="tw-h-full"> 
          <Card    
      
          :draggable="canDrag(item)"
          :objectCard="item " v-for="item in incidentListCompleted"
          @drag="onDragStart(item)"
          @dragend="onDragEnd"
          @click="handleShow(item)"
           />
        </n-card>
        <n-card @dragenter="onDragEnter('deleted')"  title="Удалённые" size="medium" class="tw-h-full"> 
          <Card    
    
          :draggable="canDrag(item)"
          :objectCard="item " v-for="item in incidentListDeleted"
          @drag="onDragStart(item)"
          @click="handleShow(item)"
          @dragend="onDragEnd"
           />
        </n-card>
      </div>
      <n-drawer v-model:show="show" :width="502" :placement="placement">
        <n-drawer-content :title="itemDraver.title" >
          <div v-html="itemDraver.description"> </div>
          
          <div v-html="itemDraver.description"> </div>
            <n-h4>Ссылка на инцдент</n-h4>
            
          <QrcodeVue :value="itemDraver.title" class=" tw-mb-3"/>
          <n-h4>Лайки</n-h4>
          <div>
            
            <Like />
          </div>
          <n-h4>Коментарии</n-h4>
            <Comment :parent_id="itemDraver.id" />
          <div>
          </div>
        </n-drawer-content>
      </n-drawer>
</template>
<script setup>
import QrcodeVue from "qrcode.vue";
import { computed, onMounted, ref } from "vue";
import { axios } from "src/boot/axios";
import Card from "./Card.vue";
import Like from "src/components/like/Like.vue";
import Comment from "../comments/Comment.vue";
import { useMessage } from "naive-ui";
const itemDrag = ref({});
const message = useMessage();
const org = JSON.parse(localStorage.getItem("org")) || {};
const show = ref(false);
const inscidentList = ref([]);
const incidentListPassive = computed(() =>
  inscidentList.value.filter((el) => el.status == "passive")
);
const itemDraver = ref({});
const incidentBackLog = computed(() =>
  inscidentList.value.filter((el) => el.status == "backlog")
);
const type = ref("passvie");
const incidentListActive = computed(() =>
  inscidentList.value.filter((el) => el.status == "active")
);
const incidentListCompleted = computed(() =>
  inscidentList.value.filter((el) => el.status == "completed")
);
const incidentListDeleted = computed(() =>
  inscidentList.value.filter((el) => el.status == "deleted")
);
onMounted(async () => {
  const { data } = await axios.get("/incident/all");
  console.log(data);
  inscidentList.value = data.incident;
});

const canDrag = (item) => {
  if (org.id == item.org_id) {
    return true;
  }

  return false;
};
const handleShow = (item) => {
  itemDraver.value = item;
  show.value = true;
};
const onDragStart = (item) => {
  console.log();
  itemDrag.value = item;
};
const onDragEnd = async () => {
  console.log(type);
  const item = inscidentList.value.find((el) => el.id == itemDrag.value.id);

  item.status = type.value;
  console.log(item);
  await axios
    .put("/incident", item)
    .then(() => {
      message.success("Успешно сделали!");
    })
    .catch((e) => {
      console.log(e.responce);
    });
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