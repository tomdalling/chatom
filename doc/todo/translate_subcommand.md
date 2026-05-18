---
status: draft
---

Add an `astu translate "<sentence>"` subcommand that outputs an English gloss.

## Goal

```
$ astu translate "mi si dog"
I/me see dog
```

Each Astu word is replaced by a short English gloss derived from its dictionary
definition. This gives a word-for-word rendering, not fluent English.

## Gloss extraction

Definitions are often longer than needed (e.g. `"I/me, first person singular pronoun"`).
Use only the first comma-delimited segment: `"I/me"`. This keeps the output concise
while covering multi-word senses (e.g. `"I/me"` stays intact).

```ruby
def gloss(entry)
  entry.definition.split(",").first.strip
end
```

## Implementation

Add a `translate` case in `CLI#run` and a `translate` private method. Internally:

1. Tokenize the input (split on whitespace).
2. Look up each token in the dictionary.
3. For unknown words, use the token itself as the gloss (with a warning or asterisk).
4. Print the glosses joined by spaces.

No need to invoke `Parser.parse` — a word-for-word gloss doesn't require grammatical
analysis and works even with words not yet in the grammar (adjectives, etc.).

Add `-h`/`--help` support matching the existing subcommand pattern.

## Acceptance criteria

- `./bin/astu translate "mi si dog"` prints a single line of English glosses.
- Unknown words appear in the output (e.g. marked with `*`) rather than causing a crash.
- `./bin/astu translate -h` prints usage.
- Unit tests in `spec/astu/cli_spec.rb` for the happy path and the unknown-word case.
- All existing tests still pass.
