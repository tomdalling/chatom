import { xmlElement } from "../xml.js";

export class Verb {
  constructor(root) {
    this.root = root;
  }

  toText() {
    return this.root;
  }

  toEnglishGloss(dictionary) {
    return dictionary.lookup(this.root)?.definition ?? this.root;
  }

  toXmlElement() {
    return xmlElement("Verb", this.root);
  }
}
