const CHARACTER_LOOKUP = {
  " ": " ",
  a: "a",
  b: "b",
  d: "d",
  e: "ɛ",
  f: "f",
  g: "g",
  h: "h",
  i: "i",
  k: "k",
  l: "l",
  m: "m",
  n: "n",
  o: "o",
  p: "p",
  r: "r",
  s: "s",
  t: "t",
  u: "u",
  v: "v",
  z: "z",
};

export function toIPA(text) {
  return [...text]
    .map((ch) => {
      if (!(ch in CHARACTER_LOOKUP)) {
        throw new Error(`No IPA mapping for character: ${ch}`);
      }
      return CHARACTER_LOOKUP[ch];
    })
    .join("");
}
