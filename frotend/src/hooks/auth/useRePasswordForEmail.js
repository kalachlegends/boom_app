import { axios } from "src/boot/axios";
import { Toast } from "src/helper/defaultAlert";
import * as yup from "yup";
import { onMounted, ref } from "vue";
import { useValidate } from "../errors/useValidate";
import { useRoute, useRouter } from "vue-router";
export const useRePasswordForEmail = () => {
  const isLoad = ref(false);
  let schema = yup.object().shape({
    password: yup.string().required(),
    repassword: yup
      .string()
      .required()
      .oneOf([yup.ref("password"), null], "Passwords must match"),
  });
  const formData = ref({
    password: "",
    repassword: "",
  });
  const [errors, validate, getKeyError] = useValidate(
    schema,
    formData,
    "array"
  );
  const route = useRoute();
  const router = useRouter();
  onMounted(async () => {
    await axios
      .get("/auth/confirm", {
        params: {
          id: route.query["request"] || "",
          number: route.query["request2"] || "",
        },
      })
      .then(() => {})
      .catch((err) => {
        router.push("/login");
      });
  });
  const handleClickRestore = async () => {
    isLoad.value = true;
    await validate();
    if (errors.value.isValid) {
      await axios
        .post("/auth/restore_password", {
          password: formData.value.password,
          confirm_id: route.query["request"],
          number: route.query["request2"],
        })
        .then((resp) => {
          axios.defaults.headers.common["Authorization"] = res.data.token;
          localStorage.setItem("token", res.data.token);
          localStorage.setItem("user", JSON.stringify(res.data.user));
          router.push("/login");

          Toast.fire({
            title: "You changed your password ",
            icon: "success",
          });
        })
        .catch((err) => {});
    }
    isLoad.value = false;
  };
  return [errors, validate, getKeyError, formData, handleClickRestore, isLoad];
};
