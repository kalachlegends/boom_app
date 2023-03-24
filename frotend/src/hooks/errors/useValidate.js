import * as yup from "yup";
import { ref } from "vue";
export const useValidate = (schema, formData, type = "object") => {
  const errors = ref({
    isValid: false,
    errors: {},
  });
  const validate = async () => {
    await schema
      .validate(formData.value, { abortEarly: false })
      .then(() => {
        errors.value.isValid = true;
        errors.value.errors = {};
      })
      .catch(function (err) {
        errors.value.isValid = false;

        errors.value.errors = yupErrorToErrorObject(err);
      });

    return true;
  };

  if (type == "object") {
    return {
      errors,
      validate,
      getKeyError,
    };
  } else return [errors, validate, getKeyError];
};

export default function getKeyError(object, key) {
  if (object[key]) return object[key][0];
  else return "";
}
function yupErrorToErrorObject(err) {
  const object = {};

  err.inner.forEach((x) => {
    if (x.path !== undefined) {
      object[x.path] = x.errors;
    }
  });

  return object;
}
