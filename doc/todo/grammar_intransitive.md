---
status: done
---

Allow intransitive sentences — subject + verb only, no object required.

## Current state

`AST::VerbPhrase` requires a `direct_object`. The parser requires exactly 3 tokens.
`"mi slip"` raises `ArgumentError: Expected exactly 3 words, got 2`.

## Changes required

### `lib/ashtu/ast/verb_phrase.rb`

Make `direct_object` optional (nilable):

```ruby
value_semantics do
  head    AST::Verb
  direct_object Either(AST::NounPhrase, nil), default: nil
end

def to_text
  direct_object ? "#{head.to_text} #{direct_object.to_text}" : head.to_text
end
```

Update `from_xml_element` to not raise when `DirectObject` is absent.

### `lib/ashtu/parser.rb`

Accept 2- or 3-token sentences (or more once adjectives land):

- 2 tokens: `[noun/pronoun, verb]` → intransitive clause
- 3 tokens: `[noun/pronoun, verb, noun/pronoun]` → transitive clause (existing)
- Otherwise: raise with a clear message

### `lib/ashtu/cli.rb`

`parse_sentence` currently re-derives subject/verb/object by index after calling
`Parser.parse` — update to handle the nil direct_object case.

## Acceptance criteria

- `./bin/ashtu parse "mi slip"` prints a Clause with no DirectObject line.
- `./bin/ashtu parse "mi si dog"` still works.
- 1-token and 4+-token inputs still produce a clear error.
- Unit tests for intransitive parse added in `spec/ashtu/parser_spec.rb`.
- All existing tests still pass.
