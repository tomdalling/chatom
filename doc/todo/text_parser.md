---
status: done_done
---

Add a plain-text Ashtu sentence parser and an `ashtu parse` CLI subcommand.

## Goal

Allow parsing a sentence like `"mi si dog"` into an `AST::Clause` without writing
XML by hand. The existing `AST.parse_xml` path stays unchanged.

## Grammar (from existing AST structure)

A sentence is: `<subject-noun> <verb> <object-noun>`

- Word order: SVO (Subject–Verb–Object)
- Parts of speech are looked up in the Dictionary
- Ambiguity is not possible by design (each word has exactly one POS in the dictionary)

## Implementation

Add `Ashtu::Parser` (new file `lib/ashtu/parser.rb`) with a class method:

```ruby
Ashtu::Parser.parse(text, dictionary:)
# => AST::Clause
```

Steps inside `parse`:
1. Split on whitespace to get tokens.
2. Look up each token in the dictionary; raise a descriptive error for unknown words.
3. Expect exactly three tokens: `[noun/pronoun, verb, noun/pronoun]`.
4. Build and return `AST::Clause` using the existing node classes.

## CLI subcommand

Add `ashtu parse "<sentence>"` that prints a structured representation of the result.
Output format is flexible — a simple pretty-print is fine to start:

```
Clause:
  Subject: mi (pronoun)
  Predicate:
    Verb: si (verb)
    DirectObject: dog (noun)
```

Add `-h`/`--help` support matching the existing subcommand pattern in `CLI`.

## Acceptance criteria

- `./bin/ashtu parse "mi si dog"` prints the structured output without error.
- Unknown words produce a clear error message.
- Wrong word count (not exactly 3 tokens) produces a clear error message.
- Unit tests for `Parser` in `spec/ashtu/parser_spec.rb`.
- All existing tests still pass.

## Notes

- The current `AST::VerbPhrase` always requires a `direct_object`. Intransitive
  sentences are out of scope for this task; raise an error if no object is given.
- Pronouns (`mi`) are a valid subject/object; the dictionary POS for them is
  `"pronoun"` — treat that as equivalent to `"noun"` for grammar purposes.
