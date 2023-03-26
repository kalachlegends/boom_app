import { ref } from "vue";
import { axios } from "src/boot/axios.js";
import { Toast } from "src/helper/defaultAlert";
import { useRouter } from "vue-router";
import { useValidate } from "../errors/useValidate";
import * as yup from "yup";
export const useRegister = () => {
  const dataForm = ref({
    email: "",
    login: "",
    password: "",
    repassword: "",
    roles: ["tenet"],
    location: {
      location_id: "",
      address: "",
    },
  });

  const isLoad = ref(false);
  const router = useRouter();

  let schema = yup.object().shape({
    login: yup.string().required(),
    email: yup.string().required().email(),
    password: yup.string().required(),
    repassword: yup
      .string()
      .required()
      .oneOf([yup.ref("password"), null], "Passwords must match"),
  });
  const { errors, validate, getKeyError } = useValidate(schema, dataForm);
  const handleClickRegister = async () => {
    isLoad.value = true;
    // await validate();
    console.log(errors);
    await axios
      .post("/auth/register", dataForm.value)
      .then((res) => {
        axios.defaults.headers.common["Authorization"] = res.data.token;
        // localStorage.setItem("token", res.data.token);
        // localStorage.setItem("user", JSON.stringify(res.data.user));

        Toast.fire({
          icon: "success",
          title: "Check Your Email adress",
        });
        // router.push("/");
      })
      .catch((err) => {
        Toast.fire({
          icon: "error",
          title: Object.values(err.response.data.error)[0],
        });
      });

    isLoad.value = false;
  };

  return {
    dataForm,
    handleClickRegister,
    isLoad,
    getKeyError,
    errors,
  };
};
