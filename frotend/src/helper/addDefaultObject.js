import { v4 as uuidv4 } from "uuid";
export const styleObject = (
  zIndex = 1,
  x = 100,
  y = 100,
  width = "200px",
  height = "200px",
  backgroundColor = "rgba(0, 0, 0, 0)"
) => {
  return {
    width,
    height,
    transform: "translate(1200px, 10px)",
    zIndex,
    display: "block",
    position: "relative",
    backgroundColor,
  };
};

export const defaultObjectElement = (type, attrs = {}) => {
  const defaultObj = {
    children: [],
    isLock: false,
    name: attrs["name"] || "",
    id: uuidv4(),
    selected: true,
    style: styleObject(attrs["zIndex"]),
  };
  if (type == "text") {
    return {
      ...defaultObj,
      type: "text",
      text: "",
    };
  } else {
    return {
      ...defaultObj,
      type: "image",
      image_url: attrs["image_url"],
    };
  }
};
