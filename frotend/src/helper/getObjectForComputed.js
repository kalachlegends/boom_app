export const getObjectForComputed = (object, key) => {
  if (object[key] != undefined) return object[key];

  return {};
};
