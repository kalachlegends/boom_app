export function compareZIndex(array) {
    return array.sort(function (a, b) {
      return b.style.zIndex - a.style.zIndex;
    });
  }