---
status: done_done
---

Add post-nominal adjective support to noun phrases.

In Ashtu, adjectives come AFTER the noun they modify: `"dog smol"` = "small dog".

## Prerequisite

`grammar_intransitive` should land first — it loosens the strict 3-token constraint
in the parser, making it easier to extend to variable-length noun phrases.

## AST changes

### New file: `lib/ashtu/ast/adjective.rb`

Mirror `AST::Noun` / `AST::Verb`:

```ruby
module Ashtu
  class AST::Adjective
    value_semantics do
      root String
    end

    def to_text = root
  end
end
```

### `lib/ashtu/ast/noun_phrase.rb`

Add an `adjectives` collection (ordered, post-nominal):

```ruby
value_semantics do
  head       AST::Noun
  adjectives ArrayOf(AST::Adjective), default: []
end

def to_text
  ([head.to_text] + adjectives.map(&:to_text)).join(" ")
end
```

Register `"Adjective"` in `AST::ELEMENT_TO_CLASS` and update `from_xml_element`
to collect all `<Adjective>` child elements inside a `<Subject>` or `<DirectObject>`.

## Parser changes (`lib/ashtu/parser.rb`)

The parser must handle variable-length noun phrases. Parsing strategy:

1. Identify the verb: scan tokens left-to-right for the first one whose POS is `"verb"`.
2. Subject noun phrase = tokens before the verb: first token must be noun/pronoun,
   remaining tokens (if any) must be adjectives.
3. Object noun phrase = tokens after the verb (optional for intransitive verbs):
   first token must be noun/pronoun, remaining tokens (if any) must be adjectives.
4. Raise `ArgumentError` for any token whose POS doesn't fit the expected role.

Examples:
- `"mi si dog smol"` → subject: mi, verb: si, object: dog + [smol]
- `"berd smol flai"` → subject: berd + [smol], verb: flai (intransitive)
- `"berd smol si dog smol"` → subject: berd + [smol], verb: si, object: dog + [smol]

## Acceptance criteria

- `./bin/ashtu parse "mi si dog smol"` shows `DirectObject: dog smol (noun, adjective)`.
- `./bin/ashtu parse "berd smol flai"` works (intransitive with adjective on subject).
- Existing simple sentences still work unchanged.
- Unit tests in `spec/ashtu/parser_spec.rb` for each case above.
- XML-based AST parsing (`AST.parse_xml`) still works for existing XML inputs.
- All existing tests still pass.
