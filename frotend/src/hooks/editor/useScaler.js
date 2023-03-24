import { onMounted, onUnmounted, ref } from "vue";

export const useScaler = (selector, attrs = {}) => {
  const element = ref(null);
  const scale = ref(1);
  const position = ref(0);
  const resizeScale = ref(0);

  const isElement = ref(false);
  const scaleOptoin = {
    scale: attrs["scale"] || 0.1,
    position: attrs["position"] || 0,
  };
  const handleScaleUp = () => {
    scale.value = scale.value + scaleOptoin.scale;
    position.value = position.value + scaleOptoin.position;
    element.value.style.scale = scale.value;
    element.value.style.top = position.value + "px";
    resizeScale.value--;
  };
  const handleScaleDown = () => {
    scale.value = scale.value - scaleOptoin.scale;
    if (position.value >= 0) {
      position.value = position.value - scaleOptoin.position;
    }
    element.value.style.scale = scale.value;
    element.value.style.top = position.value + "px";
    resizeScale.value++;
  };
  const handleSclaleReset = () => {
    scale.value = 1;
    position.value = 0;
    element.value.style.scale = scale.value;
    element.value.style.top = position.value + "px";
  };

  const listener = (e) => {
    const isElementValue = isElement.value;
    if (e.keyCode == 187 && e.ctrlKey && isElementValue) {
      e.preventDefault();
      handleScaleUp();
      //   element.value.style.width = `${element.scrollHeight}px`;
    }
    if (e.keyCode == 189 && e.ctrlKey && isElementValue) {
      e.preventDefault();
      handleScaleDown();
    }
    if (e.keyCode == 48 && e.ctrlKey && isElementValue) {
      e.preventDefault();
      handleSclaleReset();
    }
  };
  onMounted(() => {
    element.value = document.querySelector(selector);
    document.addEventListener("keydown", listener);

    document.addEventListener("mousemove", (e) => {
      const withinBoundaries = e.composedPath().includes(element.value);

      if (withinBoundaries) {
        isElement.value = true;
      } else {
        isElement.value = false;
      }
    });
  });
  onUnmounted(() => {
    document.removeEventListener("keydown", listener);
  });

  return {
    handleScaleUp,
    handleScaleDown,
    scale,
    resizeScale,
  };
};
