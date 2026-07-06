export class Entry {
  constructor({ word, partOfSpeech, definition, description = null }) {
    this.word = word;
    this.partOfSpeech = partOfSpeech;
    this.definition = definition;
    this.description = description;
  }
}

const HEADER_RE = /^(\S+)\s+\[(\w+)\]\s+(.+)$/;
const DESCRIPTION_RE = /^\s+\S/;

export class Dictionary {
  constructor(entries) {
    this.entries = entries;
  }

  static parse(text) {
    const entries = [];
    let pending = null;

    for (const line of text.split("\n")) {
      const header = line.match(HEADER_RE);
      if (header) {
        if (pending) entries.push(new Entry(pending));
        pending = {
          word: header[1],
          partOfSpeech: header[2],
          definition: header[3].trim(),
          description: null,
        };
      } else if (DESCRIPTION_RE.test(line) && pending) {
        pending.description = line.trim();
      }
    }
    if (pending) entries.push(new Entry(pending));

    return new Dictionary(entries);
  }

  lookup(word) {
    return this.entries.find((e) => e.word === word) ?? null;
  }

  search(query) {
    return this.entries.filter(
      (e) => e.definition.includes(query) || (e.description && e.description.includes(query)),
    );
  }

  list({ pos = null } = {}) {
    return pos ? this.entries.filter((e) => e.partOfSpeech === pos) : this.entries;
  }
}
