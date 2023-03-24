export const compareZindex = (a, b) => a.style.zIndex - b.style.zIndex;
export const compareZIndexArray = (array) => array.sort(compareZindex);
