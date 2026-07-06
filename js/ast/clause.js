import { xmlElement } from "../xml.js";

export class Clause {
  constructor(subject, predicate) {
    this.subject = subject;
    this.predicate = predicate;
  }

  toText() {
    return `${this.subject.toText()} ${this.predicate.toText()}`;
  }

  toEnglishGloss(dictionary) {
    return [this.subject, this.predicate].map((n) => n.toEnglishGloss(dictionary)).join(" ");
  }

  toXmlElement() {
    return xmlElement("Clause", [this.subject.toXmlElement("Subject"), this.predicate.toXmlElement()]);
  }
}
