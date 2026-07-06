import { Clause } from "./ast/clause.js";
import { VerbPhrase } from "./ast/verb-phrase.js";
import { NounPhrase } from "./ast/noun-phrase.js";
import { Noun } from "./ast/noun.js";
import { Verb } from "./ast/verb.js";
import { Adjective } from "./ast/adjective.js";

const NOUN_POS = ["noun", "pronoun"];

export function parse(text, dictionary) {
  const tokens = text.trim().split(/\s+/).filter(Boolean);

  const entries = tokens.map((token) => {
    const entry = dictionary.lookup(token);
    if (!entry) throw new Error(`Unknown word: ${token}`);
    return entry;
  });

  const verbIndex = entries.findIndex((e) => e.partOfSpeech === "verb");
  if (verbIndex === -1) throw new Error("No verb found in sentence");
  if (verbIndex === 0) throw new Error("Expected noun or pronoun as subject");

  const subjectEntries = entries.slice(0, verbIndex);
  const verbEntry = entries[verbIndex];
  const objectEntries = entries.slice(verbIndex + 1);

  if (objectEntries.length === 0) throw new Error("Expected a direct object after the verb");

  const subject = buildNounPhrase(subjectEntries, "subject");
  const directObject = buildNounPhrase(objectEntries, "object");

  return new Clause(subject, new VerbPhrase(new Verb(verbEntry.word), directObject));
}

function buildNounPhrase(entries, role) {
  const headEntry = entries[0];
  if (!NOUN_POS.includes(headEntry.partOfSpeech)) {
    throw new Error(`Expected noun or pronoun as ${role}, got: ${headEntry.partOfSpeech}`);
  }

  const rest = entries.slice(1);
  let splitIndex = 0;
  while (splitIndex < rest.length && NOUN_POS.includes(rest[splitIndex].partOfSpeech)) {
    splitIndex++;
  }
  const modifierNounEntries = rest.slice(0, splitIndex);
  const adjEntries = rest.slice(splitIndex);

  for (const entry of adjEntries) {
    if (entry.partOfSpeech !== "adjective") {
      throw new Error(`Expected adjective in ${role} noun phrase, got: ${entry.partOfSpeech}`);
    }
  }

  return new NounPhrase(
    [headEntry, ...modifierNounEntries].map((e) => new Noun(e.word)),
    adjEntries.map((e) => new Adjective(e.word)),
  );
}
