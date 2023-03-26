import { ref } from "vue";
import { axios } from "src/boot/axios.js";
import { Toast } from "src/helper/defaultAlert";
import { useRouter } from "vue-router";
import { useValidate } from "../errors/useValidate";
import * as yup from "yup";
export const useLogin = () => {
  const formData = ref({
    login: "",
    password: "",
  });
  let schema = yup.object().shape({
    login: yup.string().required(),
    password: yup.string().required(),
  });
  const { validate, getKeyError, errors } = useValidate(schema, formData);
  const isLoad = ref(false);
  const router = useRouter();
  const handleClickAuth = async () => {
    isLoad.value = true;
    await validate();
    if (errors.value.isValid)
      await axios
        .post("/auth/login", formData.value)
        .then((res) => {
          axios.defaults.headers.common["Authorization"] = res.data.token;
          localStorage.setItem("token", res.data.token);
          localStorage.setItem("user", JSON.stringify(res.data.user));
          localStorage.setItem("roles", JSON.stringify(res.data.user.roles));
          localStorage.setItem("org", JSON.stringify(res.data.org));
          console.log(res.data);
          // localStorage.setItem("my_org", JSON.stringify(res.data.org));

          Toast.fire({
            icon: "success",
            title: "You sign in",
          });
          router.push("/");
        })
        .catch((err) => {
          Toast.fire({
            icon: "error",
            title: err.response.data.error.errors,
          });
        });
    isLoad.value = false;
  };

  return {
    formData,
    handleClickAuth,
    isLoad,
    getKeyError,
    errors,
  };
};
