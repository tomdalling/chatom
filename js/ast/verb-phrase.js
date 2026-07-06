import { xmlElement } from "../xml.js";

export class VerbPhrase {
  constructor(head, directObject) {
    this.head = head;
    this.directObject = directObject;
  }

  toText() {
    return `${this.head.toText()} ${this.directObject.toText()}`;
  }

  toEnglishGloss(dictionary) {
    return [this.head, this.directObject].map((n) => n.toEnglishGloss(dictionary)).join(" ");
  }

  toXmlElement() {
    return xmlElement("Predicate", [
      this.head.toXmlElement(),
      this.directObject.toXmlElement("DirectObject"),
    ]);
  }
}
