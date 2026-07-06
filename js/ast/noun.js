import { xmlElement } from "../xml.js";

export class Noun {
  constructor(root) {
    this.root = root;
  }

  toText() {
    return this.root.charAt(0).toUpperCase() + this.root.slice(1);
  }

  toEnglishGloss(dictionary) {
    return dictionary.lookup(this.root)?.definition ?? this.root;
  }

  toXmlElement() {
    return xmlElement("Noun", this.root);
  }
}
