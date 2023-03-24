export const getOneError = (object) => {
  let entries = Object.entries(object);
  let data = entries.map(([key, val] = entry) => {
    return `The ${key} is ${val}`;
  });
  return data[0];
};
