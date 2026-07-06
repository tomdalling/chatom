import { xmlElement } from "../xml.js";

export class NounPhrase {
  constructor(nouns, adjectives = []) {
    this.nouns = nouns;
    this.adjectives = adjectives;
  }

  toText() {
    return [...this.nouns, ...this.adjectives].map((n) => n.toText()).join(" ");
  }

  toEnglishGloss(dictionary) {
    const rotated = this.nouns.length ? [...this.nouns.slice(1), this.nouns[0]] : [];
    return [...this.adjectives, ...rotated].map((n) => n.toEnglishGloss(dictionary)).join(" ");
  }

  toXmlElement(tag) {
    return xmlElement(tag, [
      ...this.nouns.map((n) => n.toXmlElement()),
      ...this.adjectives.map((a) => a.toXmlElement()),
    ]);
  }
}
