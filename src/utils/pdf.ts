import { PDFFont } from "pdf-lib";
export const fontSize = 12;
export const textMargin = 6;

export const drawSize = (fitWidth: boolean, expectWidth: number, expectHeight: number, origWidth: number, origHeight: number) => {
  if (fitWidth) {
    const drawWidth = expectWidth;
    const scale = drawWidth / origWidth;
    const drawHeight = origHeight * scale;
    return {
      containerWidth: expectWidth,
      drawWidth,
      drawHeight,
    };
  }
  const drawHeight = expectHeight;
  const scale = drawHeight / origHeight;
  const drawWidth = origWidth * scale;
  return {
    containerWidth: expectWidth,
    drawWidth,
    drawHeight,
  };
};

const isFullwidth = (char: string) => {
  const code = char.charCodeAt(0);
  return (
    (code >= 0x3000 && code <= 0x9fff) || // CJK, punctuation, kana
    (code >= 0xff00 && code <= 0xffef) // Fullwidth ASCII
  );
};

export const wrapText = (text: string, font: PDFFont, fontSize: number, maxWidth: number): string[] => {
  const lines: string[] = [];
  for (const rawLine of text.split("\n")) {
    let line = "";
    let buffer = "";

    for (let i = 0; i < rawLine.length; i++) {
      const char = rawLine[i];
      buffer += char;

      const width = font.widthOfTextAtSize(line + buffer, fontSize);
      const nextChar = rawLine[i + 1];

      const currentIsFull = isFullwidth(char);
      const nextIsFull = nextChar && isFullwidth(nextChar);

      const isBreakable = currentIsFull || (!currentIsFull && (char === " " || nextChar === " " || nextIsFull));

      if (width > maxWidth && line) {
        lines.push(line);
        line = buffer;
        buffer = "";
      }

      if (isBreakable || i === rawLine.length - 1) {
        line += buffer;
        buffer = "";
      }
    }

    if (line) lines.push(line);
  }

  return lines;
};

/*
export const wrapText = (text: string, font: PDFFont, fontSize: number, maxWidth: number) => {
  const words = text.split(" ");
  const lines = [];
  let currentLine = "";

  for (const word of words) {
    const nextLine = currentLine ? `${currentLine} ${word}` : word;
    // console.log(nextLine);
    const width = font.widthOfTextAtSize(nextLine ?? "", fontSize);
    if (width <= maxWidth) {
      currentLine = nextLine;
    } else {
      lines.push(currentLine);
      currentLine = word;
    }
  }
  if (currentLine) lines.push(currentLine);
  return lines;
};
*/
