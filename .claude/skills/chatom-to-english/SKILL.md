---
name: chatom-to-english
description: Translate Chatom into natural English in one pass, inferring the detail and intended meaning that Chatom leaves unstated (articles, tense, prepositions, clause structure, tone, who a pronoun refers to), and explaining every inference. Use for /chatom-to-english, any request to translate Chatom into English, questions like "what does ... mean in Chatom", or pasted Chatom text with a request to translate it, even for a single word.
---

# Chatom to English

Translate the Chatom text the user gives you (a word, a sentence or a passage)
into natural English. Chatom states much less than English does: it has no
articles, no prepositions, no embedded clauses and genderless
pronouns. Your job is to recover what the speaker most likely meant, to say
it the way a native English speaker would, and to show your reasoning.

`chatom.md` is the authority on the language. Never fill a gap the spec leaves
open (anything marked **⚠ Not yet specified** or listed in §22).

**First, load the `dictionary` skill.** Use it for every word lookup. This
skill is **read-only**: never write to the dictionary, and never offer to add
a word. Take every meaning from the dictionary, not from Appendix B or from
memory.

## How to work

- **One pass, no questions.** Commit to the most likely reading and explain
  it. Don't stop to ask the user to choose.
- **Use any context the user gives** ("this is a letter to a child", "the
  speaker is a chef") when inferring meaning. Never ask for context.
- **Infer, but don't invent.** The English may add what the Chatom and its
  context support, never more. Every addition that isn't in the gloss line
  goes in the inference list.

## Steps

### 1. Identify every word

Classify each word as §6.3.1 does:

1. Text between single backticks is a **code span** (a noun, §5.3). Its
   contents are not Chatom: never translate, classify or check anything inside
   it. Keep it verbatim in the English, backticks included. Adjacent code
   spans are separate nouns (describer + head).
2. A word with an uppercase letter is a **foreign name** (a noun). Adjacent
   foreign names are one name (§20.6.7). Keep it verbatim in the English.
3. A word in Appendix A is that function word.
4. A word beginning with `di`, `me` or `lai` (or `diz`, `mez`, `laiz`) is a
   **prefixed word**. Look up the root and apply §20.3. The dictionary never
   stores prefixed words.
5. Otherwise, look it up in the dictionary. For a verb, note its
   transitivity (§9.2): a verb used against it makes the sentence
   ungrammatical (step 2), and an ambitransitive verb with no object leaves
   that object unstated, which is an inference to explain.

A lowercase word that is none of these is **unknown**. Write it as `⟨word⟩`
in the gloss line. In the inference list, guess its meaning from its position
(which class it must be, §13.7) and from context, clearly labelled as a guess.
Never offer to add it.

### 2. Check the grammar

Check every sentence by hand against Appendix C, using the **checklist at the
end of `.claude/skills/english-to-chatom/SKILL.md`** (read that file). Point 10
there allows placeholders and new words; here, treat an unknown word as a
`⟨word⟩` of whatever class its position requires.

If a sentence breaks a rule, list each violation with its § reference, then
still give a best-effort translation, clearly marked
**(best effort: ungrammatical)**.

If a sentence touches an open item (§22), such as an ordinal or a fraction, say
that the spec leaves it unspecified. Translate only what the grammar does specify, and don't
decide the open item.

### 3. Parse and gloss

Find the single parse of each sentence (Appendix C), and write it in the
three-line format (§1.2): the Chatom, a word-by-word gloss using the §1.3
abbreviations, and the English in quotes. Align the columns as the spec does.

### 4. Infer the meaning

Read the whole passage before translating any sentence, because later
sentences often settle earlier ones. Infer each of these from context:

1. **Articles** (§6.2.3). "The" for something already mentioned, known, or
   unique in context; "a" for something new. Plural nouns may take no
   article. Chatom has no mass nouns (§8.12): a bare `wata` is one portion
   ("a water", "a glass of water", with the unit inferred from context), and
   `wata dem` is water in general or more than one portion, which English
   gives as "water" or "some water". An amount phrase `tu kop dem a wata` is
   "two cups of water".
2. **Tense and aspect** (§10.2). These are never inferred. A verb with no
   tense marker is always present, `bin` is past and `fina` is future, in
   every clause, whatever the earlier sentences or time phrases suggest.
   Translate the tense the Chatom states, not one you guess the writer meant.
   A verb without `am` is English simple ("eats", "ate"); `am` is English
   progressive ("is eating", "was eating").
3. **Serial verbs as English prepositions** (§9.3, §13). `tek naif kot` →
   "cut with a knife"; `tek fish gib dei` → "give them the fish"; `pon ia
   pelais` → "here"; `wid` → "with"; `guan` / `kum` → "to" / "from"; `pas` →
   "-er than"; `siem` → "as … as".
4. **Rebuilt embedded clauses** (§9.4, §18). Separate sentences that refer
   back may become one English sentence: `dag bin niam fish. dea dag bi sik.`
   → "The dog that ate the fish is sick." Reported speech with `ia` / `dea`
   becomes "said that…", "I know that…", or a direct quote, whichever reads
   best.
5. **Natural connectives.** Render linkers (§17) and the reference words
   `dea` / `ia` the way English would, not word for word. `wen` may mean
   "when" or "whenever"; `an` may mean "and then".
6. **Intensity** (§8.4.3, §12.2.2). Repeated adjectives become stronger
   English: `big big` → "very big" or "huge", `big big big` → "enormous".
7. **Fixed phrases** (§21) by their meaning: `mi luk iu.` → "Hello." Note
   which ones §22 still lists as unconfirmed.
8. **Idiomatic words.** Prefixed words and describing-noun phrases become
   the natural English word: `diseliep pelais` → "bedroom", `diniam pasin` →
   "eater", `dag diseliep pelais` → "kennel".
9. **Tone and register.** `!` and `?!` show exclamation (§5.2). `shud`
   instead of a bare command is softer and more polite (§21.2). A bare command
   may be curt or neutral, depending on context.
10. **Reference.** Decide who each `dei` / `dei dem` refers to, and whether
    `mi dem` ("we") includes the listener (§7.3).

**Gender.** Chatom pronouns have no gender (§7.2), and glosses and
translations follow §1.3.1. Use "he" or "she" only when the Chatom text itself
gives the person's gender, for example through a dictionary word glossed
"mother". Otherwise use "it" for animals and things, and singular "they" for
people and anything whose kind is unknown, with "themself" as its reflexive.
Never guess a gender from a name.

### 5. Write the result

Give the result in chat, in this order:

1. **Breakdown.** Each sentence in the three-line format (step 3), with any
   grammar violations or open items (step 2) noted directly under it.
2. **Translation.** The whole passage as fluent, idiomatic English, the way
   a native speaker would say it.
3. **Inferences.** A short bulleted list of everything the English adds or
   decides that the Chatom doesn't state, each with its reason: "*the* dog:
   already mentioned in sentence 1"; "*they*: …". Include unknown-word guesses here. Skip trivial
   inferences that have only one sensible option.
4. **Alternatives.** Only when there is something worth listing, and at most
   3 entries per sentence:
   - **Alternative meanings**: readings that really differ in meaning (who
     `dei` is, "when" vs "whenever", habitual vs present). Give the
     alternative English and one line on why it is less likely.
   - **Variations**: the same meaning with a different phrasing or tone,
     e.g. `shud seliep.` → "You should sleep." / "Why don't you get some
     sleep?"

   Leave the section out when there is nothing to list.

**Long passages.** For more than about 10 sentences, leave out the breakdown
unless the user asks for it. Still give the translation, inferences and
alternatives, and still list any grammar violations and open items, each with
the sentence it occurs in.

**A single word.** Give its class and gloss (and definition or notes, if the
dictionary has them). For a prefixed word, show the breakdown into prefix and
root and the meaning §20.3 gives it, plus the natural English word. Then give
one short example sentence in the three-line format.

## Example

Input: `mi bin luk dag. dei bin niam fish pon ia pelais. mi bi tiad tiad.`

```
mi  bin  luk  dag.
I   PST  see  dog
```
"I saw a dog."

```
dei  bin  niam  fish  pon    ia    pelais.
it   PST  eat   fish  be-at  PROX  place
```
"It ate a fish here."

```
mi  bi   tiad   tiad.
I   COP  tired  tired
```
"I am very tired."

**Translation:** "I saw a dog eat a fish here. I'm exhausted."

**Inferences:**
- *a* dog: first mention.
- *it*: `dei` most likely refers back to the dog, the only thing mentioned.
- "a dog eat a fish here": sentences 1 and 2 merged, since sentence 2 most
  likely describes what was seen. "Eat", not "eating", because sentence 2 has
  no `am`.
- "exhausted": `tiad tiad` is intensified "tired".
