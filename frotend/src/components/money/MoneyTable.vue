<template>
  <!-- <div class="tw-flex tw-justify-between">
    <div>Имя</div>
    <div>КОлво денег</div>
  </div> -->

  <n-data-table
    :columns="columns"
    :data="data"
    :pagination="pagination"
    :bordered="false"
  />
  <!-- текущий месяц -->
</template>

<script>
import { h, defineComponent } from "vue";
import { useMessage } from "naive-ui";

const createColumns = ({ play }) => {
  return [
    {
      title: "Дата",
      key: "no",
    },
    {
      title: "Откуда / Куда",
      key: "title",
    },
    {
      title: "Сумма",
      key: "length",
    },
  ];
};

const data = [
  { no: 3, title: "Wonderwall", length: "4:18" },
  { no: 4, title: "Don't Look Back in Anger", length: "4:48" },
  { no: 12, title: "Champagne Supernova", length: "7:27" },
];

export default defineComponent({
  setup() {
    const message = useMessage();
    return {
      data,
      columns: createColumns({
        play(row) {
          message.info(`Play ${row.title}`);
        },
      }),
      pagination: false,
    };
  },
});
</script>

<style lang="scss" scoped></style>
