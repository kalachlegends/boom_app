export const onlyNumbers = (value) => {
  return !value || /^\d+$/.test(value);
};
