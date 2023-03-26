import { deepFind } from "./other/deepFind";
export const requiredRules = (message, attrs = {}) => {
  const object ={
    required: true,
    message: message || "Обязательный параметр",
    trigger: attrs["trigger"] || ["input", "blur"],
  }
  if (attrs["type"] == "array") {
    object["type"] = "array"
  }
  console.log(object)
  return object;
};
export const validateNumber = (min, max) => {
  return function (role, value) {
    value = value.length;
    if (value > max) {
      return new Error(`Не должен быть больше ${max}`);
    }
    if (value < min) {
      return new Error(`Не должен быть меньше ${min}`);
    }
    return true;
  };
};

export const validateEmail = (role, value) => {
  if (!value) {
    return new Error(`Обязательный параметр`);
  }
  console.log(!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value));
  if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value)) {
    return new Error(`Не верный формат email`);
  }
  return true;
};

export const requiredRulesAndValidator = (validator, attrs = {}) => {
  return {
    required: true,

    trigger: attrs["trigger"] || ["input", "blur"],
    validator,
  };
};

export const validationPassword = (refValue, stringPath) => {
  return function (role, value) {
    if (!value) {
      return new Error(`Обязательный параметр`);
    }
    console.log(value != deepFind(refValue, "value." + stringPath));
    if (value != deepFind(refValue, "value." + stringPath)) {
      return new Error("Пароли не совпадают");
    }
    return true;
  };
};
