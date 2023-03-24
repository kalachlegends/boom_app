import { axios } from "src/boot/axios";
import { Toast } from "src/helper/defaultAlert";
import * as yup from "yup";
import { ref } from "vue";
import { useValidate } from "../errors/useValidate";
export const useRepassword = () => {
  let schema = yup.object().shape({
    email: yup.string().required().email(),
  });
  const formData = ref({
    email: "",
  });
  const isLoad = ref(false);
  const [errors, validate, getKeyError] = useValidate(
    schema,
    formData,
    "array"
  );
  const handleClickRestore = async () => {
    isLoad.value = true;
    await validate();
    if (errors.value.isValid) {
      await axios
        .post("/auth/request_restore_password", formData.value)
        .then(() => {
          Toast.fire({
            title: "Check your email adress!",
            icon: "success",
          });
        })
        .catch((err) => {
          if (err.response.status == 404) {
            Toast.fire({
              title: "Not Found email register please",
              icon: "error",
            });
          }
          if (err.response.status == 422) {
            Toast.fire({
              title: "Please check your email",
              icon: "error",
            });
          }
        });
    }
    isLoad.value = false;
  };
  return [errors, validate, getKeyError, formData, handleClickRestore, isLoad];
};
