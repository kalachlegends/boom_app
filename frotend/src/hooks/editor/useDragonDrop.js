import { ref } from "vue";
export const useDragonDrop = (size) => {
  const parentElement = ref(null);
  let isResize = ref(true);
  const style = ref({});
  const handleMouseDown = (e, arrayFunctions, myStyle) => {
    arrayFunctions.map((el) => {
      el.function(el.variable);
    });

    const element = e.currentTarget;
    const parentElem = document.body;
    let coords = getCoords(element, size.value);

    let shiftX = e.pageX - coords.left;
    let shiftY = e.pageY - coords.top;

    moveAt(e);

    function moveAt(e, boxParenElem) {
      myStyle.left = e.pageX - shiftX + "px";
      myStyle.top = e.pageY - shiftY + "px";
    }

    parentElem.onmousemove = (e) => {
      if (isResize.value) {
        moveAt(e);
      }
    };

    element.onmouseup = (e) => {
      parentElem.onmousemove = null;
      element.onmouseup = null;
    };
    element.ondragstart = function () {
      return false;
    };
    parentElem.onmouseup = (e) => {
      parentElem.onmousemove = null;
      element.onmouseup = null;
    };
  };
  const handleMouseDownResize = (e, myStyle) => {
    
  };
  return {
    handleMouseDown,
    parentElement,
    handleMouseDownResize,
  };
};

