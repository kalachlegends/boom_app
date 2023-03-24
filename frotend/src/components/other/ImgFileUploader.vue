<template>
  <div class="tw-flex tw-flex-col tw-gap-3">
    <div class="tw-flex tw-items-center tw-gap-2 tw-relative">
      <label class="custom-file-upload">
        <input
          type="file"
          accept=".jpg,.jpeg,.png,.svg,.gif"
          @change="handleChangeFileMy"
        />
        <span>Upload File</span>
        <div class="file-name"><q-icon name="note_add" />{{ fileName }}</div>
      </label>

      <btn-default @click="handleClickUploadImageMy" width="fit-content">
        Save</btn-default
      >
      <q-inner-loading :showing="isLoadImage" label="Please wait..." />
    </div>

    <!-- <p
      class="tw-mt-1 tw-text-sm tw-text-gray-500 tw-dark:text-gray-300"
      id="file_input_help"
    >
      SVG, PNG, JPG or GIF (MAX. 800x400px).
    </p> -->
  </div>
</template>
<script>
export default {
  name: "img-file-uploader",
};
</script>
<script setup>
import { ref, onMounted, computed } from "vue";
import { useUploadImage } from "src/hooks/editor/image/useUploadImage";

const props = defineProps({
  table_type: {
    default: "global",
    type: String,
  },
  type_img: {
    default: "global",
    type: String,
  },
  parent_id: {
    default: "",
    type: String,
  },
  callbackFunction: {
    default: () => "",
    type: Function,
  },
});
const emit = defineEmits(["update:imgLink"]);
const fileName = ref("Choose File");
const [isLoadImage, file, handleClickUploadImage, handleChangeFile, imgLink] =
  useUploadImage("", {
    params_form: {
      table_type: props.table_type,
      type_img: props.type_img,
      parent_id: props.parent_id,
    },
  });
const handleChangeFileMy = (e) => {
  handleChangeFile(e);
  fileName.value = file.value.name;
};
const handleClickUploadImageMy = async (e) => {
  await handleClickUploadImage();
  emit("update:imgLink", imgLink.value);
  if (file.value == null) {
    fileName.value = "Chosee File";
  }
};
onMounted(() => {});
</script>

<style lang="scss" scoped>
.file {
  background: #000;
}
.custom-file-upload {
  cursor: pointer;
  display: flex;
  gap: 10px;
  span {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 8px 15px;
    background: #2c2c2c;
    box-shadow: 0px 0px 15px rgb(0 0 0 / 25%);
    border-radius: 7px;
    color: white;
    font-weight: 500;
    text-transform: uppercase;
    transition: all 0.3s;
  }
}
input[type="file"] {
  display: none;
}
.file-name {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}
</style>