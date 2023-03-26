<template lang="">
  <div class="tw-flex tw-justify-between">
    <n-statistic label="Всего задач">
      {{incidentListPassive.length + incidentBackLog.length + incidentListActive.length + incidentListCompleted.length + incidentListDeleted.length}}
    </n-statistic>
    <n-form-item label="Приоритет" path="priority">
        <n-select v-model:value="priorityFilter" placeholder="Приоритет" :options="filtersPriority" />
    </n-form-item>
    <n-form-item label="Организации" path="organization">
        <n-select multiple filterable v-model:value="orgFilter" placeholder="Организации" :options="filtersOrgs" />
    </n-form-item>
    <n-statistic label="Сделано">
      {{incidentListCompleted.length}}
    </n-statistic>

  </div>
    <div class="tw-flex tw-gap-3 tw-justify-between tw-min-h-full tw-h-full">
      <n-card  v-if="isManager()" title="Бек Лог">
        <Card    
          
        :objectCard="item " v-for="item in incidentBackLog"
        :draggable="canDrag(item, true)"
        @click="handleShow(item)"
        @drag="onDragStart(item)"
        @dragend="onDragEnd(true)"
        />
           
      </n-card>

        <n-card title="Неактивные" size="medium" @dragenter="onDragEnter('passive')"     class="tw-h-full tw-gap-3 tw-flex tw-flex-col">
        <Card    
          
        :objectCard="item " v-for="item in incidentListPassive"
        :draggable="canDrag(item, false)"
        @click="handleShow(item)"
        @drag="onDragStart(item)"
        @dragend="onDragEnd(false)"
        />
           
        </n-card>
        <n-card v-if="!isManager()" @dragenter="onDragEnter('active')"  title="Активные" size="medium" class="tw-h-full"> 
            <Card    
            :draggable="canDrag(item, false)"
            :objectCard="item " v-for="item in incidentListActive"
            @drag="onDragStart(item)"
            @click="handleShow(item)"
            @dragend="onDragEnd(false)"
             />
               
        </n-card>
        <n-card v-if="!isManager()" @dragenter="onDragEnter('completed')" title="Готовые" size="medium" class="tw-h-full"> 
          <Card    
      
          :draggable="canDrag(item, false)"
          :objectCard="item " v-for="item in incidentListCompleted"
          @drag="onDragStart(item)"
          @dragend="onDragEnd(false)"
          @click="handleShow(item)"
           />
        </n-card>
        <n-card v-if="!isManager()" @dragenter="onDragEnter('deleted')"  title="Удалённые" size="medium" class="tw-h-full"> 
          <Card    
    
          :draggable="canDrag(item, false)"
          :objectCard="item " v-for="item in incidentListDeleted"
          @drag="onDragStart(item)"
          @click="handleShow(item)"
          @dragend="onDragEnd(false)"
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
const org = JSON.parse(localStorage.getItem("org")) || {}
const roles = JSON.parse(localStorage.getItem("roles"))
const user = JSON.parse(localStorage.getItem("user"))
const show = ref(false);
const inscidentList = ref([]);
const incidentListPassive = computed(() =>
  inscidentList.value.filter((el) => el.status == "passive" && (el.priority == priorityFilter.value || priorityFilter.value == "none") && (orgFilter.value.includes(el.org_id) || orgFilter.value.length == 0))
);
const itemDraver = ref({});
const incidentBackLog = computed(() =>
  inscidentList.value.filter((el) => el.status == "backlog" && (el.priority == priorityFilter.value || priorityFilter.value == "none") && (orgFilter.value.includes(el.org_id) || orgFilter.value.length == 0))
);
const priorityFilter = ref("none")
const orgFilter = ref([])
const filtersOrgs = ref([])
const type = ref("passive");
const filters = ref({ priority: "none", organizations: [] })
const incidentListActive = computed(() =>
  inscidentList.value.filter((el) => el.status == "active" && (el.priority == priorityFilter.value || priorityFilter.value == "none") && (orgFilter.value.includes(el.org_id) || orgFilter.value.length == 0))
);
const incidentListCompleted = computed(() =>
  inscidentList.value.filter((el) => el.status == "completed" && (el.priority == priorityFilter.value || priorityFilter.value == "none") && (orgFilter.value.includes(el.org_id) || orgFilter.value.length == 0))
);
const incidentListDeleted = computed(() =>
  inscidentList.value.filter((el) => el.status == "deleted" && (el.priority == priorityFilter.value || priorityFilter.value == "none") && (orgFilter.value.includes(el.org_id) || orgFilter.value.length == 0))
);

onMounted(async () => {
  const { data } = await axios.get("/incident/all");
  const respOrg = await axios.get("/organization/all");
  inscidentList.value = data.incident;
  filtersOrgs.value = respOrg.data.organization.map((elem) => { return { label: elem.title, value: elem.id } })
  console.log([inscidentList.value, orgFilter.value])
});
const filtersPriority = [
  {
    label: "Без фильтра",
    value: "none",
  },
  {
    label: "Низкий",
    value: "low",
  },
  {
    label: "Средний",
    value: "medium",
  },
  {
    label: "Высокий",
    value: "high",
  },
]
const canDrag = (item, is_manager) => {
  if ((org.id == item.org_id) || (is_manager && roles.includes("manager"))) {
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
const onDragEnd = async (is_manager) => {
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
const isManager = () => {
  if (roles.includes("manager")) {
    return true
  }
  return false
}
const onDragEnter = (typeREf) => {
  type.value = typeREf;
};
</script>
<style  lang="scss">
.n-card>.n-card__content {
  flex: 1;
  display: flex;
  gap: 10px;
  min-width: 0;
  flex-direction: column;
}
</style>