<template>
  <div class="tw-flex tw-justify-between tw-mt-5">
    <n-thing :title="'Общая сумма'" :description="movementSum" />
    <n-thing :title="'Общая сумма внесения'" :description="movementSumType1" />
    <n-thing
      :title="'Общая сумма вычетания'"
      :description="movementSumType0"
    />
  </div>
  <n-data-table
    :columns="columns"
    :data="movementAll"
    :bordered="true"
    class="tw-mt-3"
  />
  <canvas id="chart" ref="chart" class=" tw-max-w-xs tw-w-full tw-max-h-96"></canvas>
</template>

<script setup>
import { h, defineComponent, onMounted, ref, computed } from "vue";
import { useMessage } from "naive-ui";
import { axios } from "src/boot/axios";
import Chart from "chart.js/auto";
const chart = ref(null);

const columns = [
  {
    title: "Дата",
    key: "inserted_at",
  },
  {
    title: "Тип операции",
    key: "movement",
    render(row) {
      if (row.movement == 1) {
        return "Внесение";
      }
      return "Изъятие";
    },
  },
  {
    title: "Сумма",
    key: "cash.bills",
  },
  {
    title: "Что произлошло?",
    key: "type",
  },
];
const org = localStorage.getItem("org");
const movementAll = ref([]);
const movementSum = computed(() => {
  return movementAll.value.reduce((prev, current) => {
    return prev + current.cash.bills;
  }, 0);
});
const movementSumType1 = computed(() => {
  return movementAll.value.reduce((prev, current) => {
    if (current.movement == 1) {
      return prev + current.cash.bills;
    }
    return prev;
  }, 0);
});
const movementSumType0 = computed(() => {
  return movementAll.value.reduce((prev, current) => {
    if (current.movement == 0) {
      return prev + current.cash.bills;
    }
    return prev;
  }, 0);
});
onMounted(async () => {
  console.log(document.querySelector("#chart"));

  await axios
    .get("/money/movement/all", {
      params: {
        org_id: org.id,
      },
    })
    .then(({ data }) => {
      movementAll.value = data.moneymovement;
    });

  console.log(movementSumType0.value);
  const myChart = new Chart(document.querySelector("#chart"), {
    type: "doughnut",
    data: {
      labels: ["Общая сумма", "Общий вычет", "Общее изъятие"],
      datasets: [
        {
          data: [
            movementSum.value,
            movementSumType0.value,
            movementSumType1.value,
          ],
          borderWidth: 1,
        },
      ],
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          position: "top",
        },
        title: {
          display: true,
        },
      },
    },
  });
});
</script> 
