export function drawImageProp(ctx, img, x, y, w, h, offsetX, offsetY) {
  if (arguments.length === 2) {
    x = y = 0;
    w = ctx.canvas.width;
    h = ctx.canvas.height;
  }

  // default offset is center
  offsetX = typeof offsetX === "number" ? offsetX : 0.5;
  offsetY = typeof offsetY === "number" ? offsetY : 0.5;

  // keep bounds [0.0, 1.0]
  if (offsetX < 0) offsetX = 0;
  if (offsetY < 0) offsetY = 0;
  if (offsetX > 1) offsetX = 1;
  if (offsetY > 1) offsetY = 1;

  var iw = img.width,
    ih = img.height,
    r = Math.min(w / iw, h / ih),
    nw = iw * r, // new prop. width
    nh = ih * r, // new prop. height
    cx,
    cy,
    cw,
    ch,
    ar = 1;

  // decide which gap to fill
  if (nw < w) ar = w / nw;
  if (Math.abs(ar - 1) < 1e-14 && nh < h) ar = h / nh; // updated
  nw *= ar;
  nh *= ar;

  // calc source rectangle
  cw = iw / (nw / w);
  ch = ih / (nh / h);

  cx = (iw - cw) * offsetX;
  cy = (ih - ch) * offsetY;

  // make sure source rectangle is valid
  if (cx < 0) cx = 0;
  if (cy < 0) cy = 0;
  if (cw > iw) cw = iw;
  if (ch > ih) ch = ih;

  // fill image in dest. rectangle

  ctx.drawImage(img, cx, cy, cw, ch, x, y, w, h);
}
export const parserCanvasObject = (e, type = "text") => {
  const width = parseInt(e.width.replace("px", ""));
  const height = parseInt(e.height.replace("px", ""));
  const offset = getOffest(e.transform);
  let fontFamily = "",
    fontSize = "",
    font = "",
    isVisible = true;

  if (type == "text") {
    // fonSize = parseInt(e.fonSize.replace("px", ""));
    fontSize = e.fontSize || "16px";

    fontFamily = e.fontFamily || "Montserrat, sans-serif";
    font = `${fontSize} ${fontFamily}`;
  }

  if (e.dispay == "none") isVisible = false;

  return {
    font,
    isVisible,
    backgroundColor: e.backgroundColor,
    fontFamily,
    fontSize,
    fontSizeInt: parseInt(fontSize.replace("px", "")),
    zIndex: e["zIndex"],
    width,
    height,
    x: offset.x - 1200,
    y: offset.y,
  };
};
export function wrapText(ctx, text, maxWidth, x, y, lineHeight) {
  const xOffset = x;
  let yOffset = y;

  const lines = text.split("\n");
  const fittingLines = [];
  for (let i = 0; i < lines.length; i++) {
    if (ctx.measureText(lines[i]).width <= maxWidth) {
      fittingLines.push([lines[i], xOffset, yOffset]);
      yOffset += lineHeight;
    } else {
      let tmp = lines[i];
      while (ctx.measureText(tmp).width > maxWidth) {
        tmp = tmp.slice(0, tmp.length - 1);
      }
      if (tmp.length >= 1) {
        const regex = new RegExp(`.{1,${tmp.length}}`, "g");
        const thisLineSplitted = lines[i].match(regex);
        for (let j = 0; j < thisLineSplitted.length; j++) {
          fittingLines.push([thisLineSplitted[j], xOffset, yOffset]);
          yOffset += lineHeight;
        }
      }
    }
  }
  return fittingLines;
}

export function imagePromise(src, type = "img") {
  if (type == "img") {
    return new Promise(async (resolve, reject) => {
      let myImg = new Image();
      myImg.onload = function () {
        return resolve(myImg);
      };

      myImg.src = src;

      myImg.onerror = reject;
    });
  } else {
    return new Promise(async (resolve, reject) => {
      // let myImg = new GIF();
      myImg.onload = function () {
        return resolve(myImg);
      };

      myImg.load(src);

      myImg.onerror = reject;
    });
  }
}
export const getOffest = (string) => {
  if (string == undefined || string == null)
    return {
      x: 0,
      y: 0,
    };
  const match = string.match(/-?\d+px/g);
  const left = parseInt(match[0].replace("px", ""));
  const top = parseInt(match[1].replace("px", ""));

  return {
    x: left,
    y: top,
  };
};
