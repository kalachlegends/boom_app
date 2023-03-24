import { onMounted } from "vue";

export const useKeyBoard = (seletedElements) => {
  const { callBackCtrlZ } = useCtrlZandDelete(seletedElements);
  const { callBackParenthess } = useParentheses(seletedElements);
  onMounted(() => {
    window.addEventListener("keydown", (e) => {
      callBackCtrlZ(e);
      callBackParenthess(e);
    });
  });
};
const useParentheses = (seletedElements) => {
  const callBackParenthess = (e) => {
    if (e.ctrlKey && e.keyCode == 219) {
      seletedElements.value.forEach((el, index, array) => {
        const elem = array[index - 1];
        if (el.selected) {
          if (elem != undefined) {
            elem.style.zIndex = elem.style.zIndex + 1;
            el.style.zIndex = el.style.zIndex - 1;
          }
        }
      });
    }
    if (e.ctrlKey && e.keyCode == 221) {
      seletedElements.value.forEach((el, index, array) => {
        const elem = array[index + 1];
        if (el.selected) {
          if (elem != undefined) {
            elem.style.zIndex = elem.style.zIndex - 1;
            el.style.zIndex = el.style.zIndex + 1;
          }
        }
      });
    }
  };
  return {
    callBackParenthess,
  };
};

const getElementsBySelected = (elements) =>
  elements.filter((el) => el.selected);
const getElementsBySelectedNot = (elements) =>
  elements.filter((el) => !el.selected);
const useCtrlZandDelete = (seletedElements) => {
  onMounted(() => {
    localStorage.removeItem("ctrl-z-object");
    localStorage.setItem("ctrl-z-object", JSON.stringify([]));
  });
  const callBackCtrlZ = (e) => {
    if (e.keyCode == 46) {
      let ctrlZObject = JSON.parse(localStorage.getItem("ctrl-z-object"));
      const elementsSelected = getElementsBySelected(seletedElements.value);
      if (ctrlZObject.length != 0) {
        ctrlZObject.push(...elementsSelected);
        localStorage.setItem("ctrl-z-object", JSON.stringify(ctrlZObject));
      } else {
        localStorage.setItem(
          "ctrl-z-object",
          JSON.stringify([...elementsSelected])
        );
      }
      seletedElements.value = getElementsBySelectedNot(seletedElements.value);
    }
    if (e.keyCode == 90 && e.ctrlKey) {
      let ctrlZObject = JSON.parse(localStorage.getItem("ctrl-z-object"));

      if (ctrlZObject.length != 0) {
        seletedElements.value.push(ctrlZObject.pop());
        localStorage.removeItem("ctrl-z-object");
        localStorage.setItem("ctrl-z-object", JSON.stringify(ctrlZObject));
      } else {
        localStorage.setItem("ctrl-z-object", JSON.stringify([]));
      }
    }
  };

  return {
    callBackCtrlZ,
  };
};
