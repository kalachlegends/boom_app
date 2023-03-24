import { ref, onMounted, onUnmounted } from "vue";
export const useIsKey = (code) => {
  const isKey = ref(false);
  const handleKeyIs = (e) => {
    if (e.keyCode == code) isKey.value = true;
  };

  const handleKeyUp = () => {
    isKey.value = false;
  };
  onMounted(() => {
    document.addEventListener("keydown", handleKeyIs);
    document.addEventListener("keyup", handleKeyUp);
  });

  onUnmounted(() => {
    document.removeEventListener("keydown", handleKeyIs);
    document.addEventListener("keyup", handleKeyUp);
  });
  return isKey;
};
