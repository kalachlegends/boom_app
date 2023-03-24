import { ref, onMounted } from "vue";
import { useIsKey } from "src/hooks/editor/useIsKey.js";
export const useSelected = (array, type) => {
  const seletedElements = ref(array);
  const isKey = useIsKey(16);
  const handleClickChangeSelect = (index, event) => {
    if (event.which == 1)
      if (type == "editor") {
        if (!isKey.value) {
          seletedElements.value = seletedElements.value.map((el) => {
            if (el.selected) {
              el.selected = false;
            }
            return el;
          });
          console.log(
            seletedElements.value.find((e) => e.id == index).selected
          );
          seletedElements.value.find((e) => e.id == index).selected = true;
        } else {
          seletedElements.value.find((e) => e.id == index).selected = true;
        }
      } else {
        if (seletedElements.value[index].selected) {
          seletedElements.value[index].selected = false;
        } else {
          seletedElements.value[index].selected = true;
        }
      }
  };
  const getOnlySelectedElements = (type) => {
    if (type == "find") {
      return findBySelectObject(seletedElements.value);
    }
    return filterBySelectObject(seletedElements.value) || [];
  };

  return {
    handleClickChangeSelect,
    seletedElements,
    getOnlySelectedElements,
  };
};

export const helperAddSelected = (array) => {
  return array.map((element) => {
    return {
      ...element,
      selected: false,
    };
  });
};
export const filterBySelectObject = (elements) =>
  elements.filter((el) => el.selected);
export const findBySelectObject = (elements) =>
  elements.find((el) => el.selected);
