---
name: dictionary
description: Look up, add, change or remove Chatom words in dictionary.sqlite. Use whenever a task touches the Chatom dictionary or vocabulary - looking up a word or its English meaning, checking a word's class, proposing or coining a new word, or resyncing the dictionary after chatom.md changes.
---

# The Chatom dictionary

`dictionary.sqlite` (repo root) is the Chatom dictionary referred to in `chatom.md`
§6.1. It holds **every** Chatom word, both the words defined by the spec and the
open-class words that the spec leaves to the dictionary. `chatom.md` still wins
any conflict (CLAUDE.md rule 2).

## Rules

1. **Reading is free.** Query the database whenever it helps.
2. **Every write needs the user's explicit approval.** That covers adding,
   editing, reclassifying or deleting a dictionary word. Propose the exact change
   in chat (the word, class, gloss, definition and notes), and wait for an
   explicit "yes". Approval covers only the change it was given for.
3. **Proposals live only in the chat.** Never store a proposed or unapproved
   word anywhere: not in the database, not in a file, not in memory.
4. **Spec words are read-only.** A spec word is any row with a `subclass`. Change
   spec rows only to resync with `chatom.md` after the user has edited the spec
   (see below). Never change the spec to match the database.
5. **Run `bin/validate` after every write.** If it fails, fix the problem or
   undo the write before doing anything else.
6. **Never store prefixed words** (`di-`, `me-`, `lai-` and their `z` forms).
   Their meaning always follows from the root (§20.5.5), so look up the root
   and apply §20.3.
7. **One spelling, one class.** `word` is the primary key. A spelling can never
   be both a noun and a verb, for example.

## Schema

```sql
CREATE TABLE words (
  word       TEXT PRIMARY KEY,  -- lowercase a-z only
  class      TEXT NOT NULL,     -- noun | verb | adjective | function
  subclass   TEXT,              -- set only for spec words (see below)
  gloss      TEXT NOT NULL,     -- short English meanings, comma-separated
  definition TEXT,              -- optional longer explanation
  notes      TEXT,              -- optional usage notes
  created_at TEXT NOT NULL,     -- ISO 8601 UTC, set by default
  updated_at TEXT NOT NULL      -- maintained by a trigger
) WITHOUT ROWID;
```

`PRAGMA user_version` holds the schema version (currently 1). Any schema change
needs the user's approval and must bump the version and update `bin/validate`.

### Classes and subclasses

| class | subclass | source |
|---|---|---|
| `function` | `pronoun` `plural` `demonstrative` `question` `tense` `aspect` `modal` `negation` `answer` `copula` `linker` `quantifier` `digit` (always required) | spec, Appendix A.1 |
| `noun` | `general` | spec, Appendix A.2 |
| `verb` | `core` | spec, Appendix A.3 |
| `noun` `verb` `adjective` | NULL | dictionary |

So a row comes from the spec exactly when its `subclass` is not NULL.

## Recipes

```sh
# Look up an Chatom word
sqlite3 -header -column dictionary.sqlite "SELECT * FROM words WHERE word = 'dag'"

# English -> Chatom
sqlite3 -header -column dictionary.sqlite \
  "SELECT word, class, gloss FROM words WHERE gloss LIKE '%dog%'"

# All open-class words of one class
sqlite3 dictionary.sqlite "SELECT word, gloss FROM words WHERE class = 'verb' AND subclass IS NULL ORDER BY word"

# Is a spelling taken?
sqlite3 dictionary.sqlite "SELECT class FROM words WHERE word = 'kiat'"
```

Writes (only after approval, and always followed by `bin/validate`):

```sh
sqlite3 dictionary.sqlite "INSERT INTO words (word, class, gloss) VALUES ('siton', 'noun', 'stone, rock')"
sqlite3 dictionary.sqlite "UPDATE words SET gloss = 'dog, hound' WHERE word = 'dag'"
sqlite3 dictionary.sqlite "DELETE FROM words WHERE word = 'siton'"
bin/validate
```

Quote SQL strings carefully: a `'` inside a value is written as `''`.

## What `bin/validate` checks

- Every word fits the word shape `C? N (C N)* F?` (§3.3), with no doubled
  vowels (§2.1.1).
- No word begins with `di`, `me` or `lai` (§3.2.1), and no noun, verb or
  adjective begins with `z` (§3.2.2).
- The rows with a subclass are exactly the words of Appendix A (without the
  prefixes), with the right class and subclass. Each gloss must match the
  Meaning column where the spec gives a per-word meaning. The digit glosses
  are not checked.
- Every Appendix B word is present with the same class. Glosses may differ.
- The schema version.

The schema itself rejects bad classes, non-`a-z` spellings, function words
without a subclass, and duplicate spellings.

## Resyncing after a spec edit

When the user changes Appendix A or B in `chatom.md`, run `bin/validate` and fix
each reported row to match the spec. A new function word needs a subclass. If
it isn't obvious, ask the user, then add it to `FUNCTION_SUBCLASSES` in
`bin/validate`. If a new spec word is already a dictionary word, tell the user;
don't silently reclassify it.

## Proposing new words

Before proposing a word, check that the spelling is free, that it fits the shape
rules, and that the concept isn't already covered (including by a prefixed word
or a describing-noun phrase, §20.4). Propose the full row and briefly explain
where the form comes from.

### Style guide for coining roots (non-normative)

These guidelines describe the feel of the existing vocabulary. They are not
part of the spec, and the user's judgement overrides them.

1. Roots are loosely inspired by Jamaican Patois and other English-based
   creoles, and by English as spoken in Australia. Start from the everyday
   English word, or from a creole word where one exists (`niam` from Patois
   *nyam* "eat", `sabi` from pidgin *savvy* "know"). Then reshape it to fit
   Chatom's sounds and word shape.
2. Spell it by sound using §2, not by English spelling (`naif` knife, `fish`).
   The sound /ŋ/ ("ng" in "sing") is written `nh` wherever it occurs, including
   at the start of a word (`sinh` sing).
3. Break up consonant clusters by inserting a vowel, usually one that echoes a
   nearby vowel (`bared` bread, `seliep` sleep, `pelais` place).
4. Drop sounds Chatom lacks, or replace them with the nearest Chatom sound. A final
   "r" disappears, as in Australian English (`tiad` tired).
5. Prefer the shortest form that stays recognisable.
6. If the result clashes with an existing word, or breaks a shape rule, adjust
   it and say so when you propose it.

## Setup

Run `bin/setup` once per checkout. It makes `git diff` show `dictionary.sqlite`
as SQL, and it installs a pre-commit hook that runs `bin/validate`.
