---
name: english-to-chatom
description: Translate English into Chatom interactively. Offers alternative Chatom structures for the user to pick from, offers options for any word missing from the dictionary, and asks whether to add new words. Use for /english-to-chatom, any request to translate English into Chatom, or questions like "how do I say ... in Chatom" or "what's the Chatom for ...", even for a single word.
---

# English to Chatom

Translate the English text the user gives you (a word, a sentence or a
paragraph) into Chatom, letting the user make every choice along the way.

`chatom.md` is the authority on the language. Every candidate you show must
conform to it. Never fill a gap the spec leaves open (anything marked
**⚠ Not yet specified** or listed in §22).

**First, load the `dictionary` skill.** Use it for every lookup, every word
proposal and every write. Its rules (approval, `bin/validate`, the coining
style guide, no stored prefixed words, proposals live only in the chat) apply
here unchanged.

## How to ask

Ask every choice with the `AskUserQuestion` tool:

- At most 4 options per question and 4 questions per call. If there are more,
  use several calls.
- Put each candidate's three-line example (§1.2) in the option's `preview`.
- Put your recommendation first, with "(Recommended)" at the end of its label.
- The user may answer "Other" with free text. Treat it as described in each
  step below.

## Steps

### 1. Settle the meaning

If the English has more than one reasonable reading ("I saw her duck", "old
men and women"), ask which one is meant before doing anything else. Skip this
step when the meaning is clear.

### 2. Look up the words

For each content word in the English, search the dictionary by gloss (see the
`dictionary` skill's recipes). Also consider prefixed words built from
dictionary roots (§20.3) and describing-noun phrases (§8.3, §20.4). Note which
concepts have no Chatom word yet.

Names come in two kinds (§20.6). A **native name** such as `chatom` is an
ordinary lowercase dictionary noun: look it up like any other word. A **foreign
name** (people, places, products...) contains an uppercase letter and is
written verbatim, keeping its capitals; never look one up or add it. Offer an
adapted spelling (`Sara` for Sarah) only if the user asks for one. Join a
lowercase part of a foreign name with hyphens: `Leonardo-da-Vinci`.

### 3. Offer structures

Offer **2–4 genuinely different** ways to express the meaning: different
grammatical strategies or word choices, for example a serial verb vs separate
clauses (§9.4, §13), reported speech with `ia`/`dea` (§18), a comparison with
`pas` vs another phrasing (§14), or a describing-noun phrase vs a new root.
Don't offer trivial variants, such as the same sentence with and without an
optional `bin`. If only one structure is reasonable, say so and offer it alone
for confirmation.

For each option:

- the preview shows the three-line format, with missing words as
  placeholders: `⟨cheese⟩` in the Chatom line, `cheese` in the gloss;
- the description is one line on how its meaning differs from the English or
  from the other options.

One English sentence may become several Chatom sentences. That is normal,
because Chatom has no embedded clauses.

If the user answers "Other" with an edit ("option 2 but with `kaz`"), rebuild
that option, check it again (see the checklist), and ask again. Never accept an
edit unchecked.

### 4. Flag what Chatom can't say

Before or alongside the structures, say plainly what the translation loses or
can't express:

- things the grammar lacks: articles (§6.2.3), the tense the English left
  vague, vocatives (§9.5.3), commas, adverbs;
- open items from §22 ("each other", ordinals, fractions, decimals, whether
  `ziro` takes `dem`).

Offer workarounds that use only specified grammar. Never propose a new
function word, and never guess at an open item. If a gap needs a new function
word or rule, say that it would be a change to `chatom.md` and that the user
decides it (CLAUDE.md rule 3).

### 5. Fill missing words

For every placeholder in the chosen structure, ask one question with at most 4
options, in this order:

1. **Existing words first**: a prefixed word (§20.3), a describing-noun phrase
   (§20.4), or a near-synonym already in the dictionary.
2. **New roots**: two or three coined per the `dictionary` skill's style guide.
   Each description says where the form comes from.

Only nouns, verbs and adjectives can be new words. Before offering a new root,
check that:

- it fits the word shape `C? N (C N)* F?` (§3.3), with no doubled vowel;
- it doesn't begin with `di`, `me` or `lai`, or with `z` (§3.2);
- its spelling isn't taken, by a function word or any dictionary word;
- it is all lowercase (a word with a capital would be a foreign name).

If the user types their own word under "Other", run the same checks. If it
fails, explain why and offer fixed versions. If the user asks for more options,
offer more.

### 6. Offer to add new words

List every new root the user chose as a full proposed row: `word`, `class`,
`gloss`, `definition`, `notes`. Ask once whether to add all, some or none of
them. Write only the approved rows, then run `bin/validate`, following the
`dictionary` skill. Don't commit.

A chosen word the user declines stays in the translation, marked
`(not in dictionary)`. Store it nowhere: not in the database, a file or
memory.

### 7. Give the result

In chat only, give the final translation in the three-line format, with the
English in quotes. Then list:

- any words added to the dictionary;
- any words used but not added, marked `(not in dictionary)`;
- anything the translation couldn't express (step 4).

## Checklist for every candidate

There is no parser, so check each candidate by hand against Appendix C before
showing it:

1. **Sentence**: ends in `.` `?` `!` or `?!`; ends in `?`/`?!` exactly when it
   is a question; every sentence has a full clause (except `ie.` and `no.`).
2. **Clause**: subject – (`no`) (`bin`/`fina`) (`am`) (modal) – verb chain, in
   that order, each at most once (§10.4). No preposition, no embedded clause.
3. **Linking words**: exactly one between clauses, never at the start
   (§17). Command clauses come before all other clauses (§17.6). No tense or
   aspect in a command (§16.3).
4. **Questions**: yes/no questions end in `no`; `wa` questions don't. No
   question in a sentence containing a command (§15.4).
5. **Noun phrase**: determiner – count – adjectives – describing nouns – head –
   `dem` (§8.2). At most one determiner. Adjectives describe the head.
6. **Plural**: `dem` after every plural noun, even with a number; never after a
   pronoun, after `eri`/`notin`, or after a possessor followed by `deidem`
   (§8.5, §8.8.5).
7. **Possession**: pronoun possessors are bare; noun possessors take `dei`
   (singular) or `deidem` (plural); the thing owned has a noun head (§8.8.9).
8. **`bi`**: bare adjectives only after `bi`, and only when no noun follows
   (§12.2.3). Existence uses `abi`, which never takes an object.
9. **Words**: every word is a function word, a dictionary word, a valid
   prefixed word (one prefix, the right class, not on a function word or a
   foreign name, §20.5), a foreign name, or a marked placeholder or new word.
10. **One parse**: read the sentence as a parser would, and make sure no word
    could be taken as the start of a different phrase.
