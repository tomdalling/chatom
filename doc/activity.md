## 2026-05-17 (grammar_intransitive)

Completed `grammar_intransitive` task (status: ready → done).

- Updated `AST::VerbPhrase` in `lib/ashtu/ast/verb_phrase.rb`: made `direct_object` optional with `Either(AST::NounPhrase, nil), default: nil`; updated `to_text` to omit object when nil; updated `from_xml_element` to handle absent `DirectObject` element.
- Updated `lib/ashtu/parser.rb`: replaced 3-token requirement with 2–3 token range; `direct_object` is nil for intransitive sentences.
- Updated `lib/ashtu/cli.rb`: `parse_sentence` now omits the `DirectObject:` line when there is no object.
- Updated `spec/ashtu/parser_spec.rb`: replaced "raises when not exactly 3 tokens" test with intransitive parse test and 1-token error test; updated error message regex to `/Expected 2 or 3 words/`.
- Ran `bundle exec rspec`: 37 examples, 0 failures.
- Manually verified: `./bin/ashtu parse "mi slip"` → Clause with no DirectObject; `./bin/ashtu parse "mi si dog"` → unchanged; `./bin/ashtu parse "mi"` → error.
- No issues encountered.

## 2026-05-17 (text_parser)

Completed `text_parser` task (status: ready → done_done).

- Created `lib/ashtu/parser.rb` with `Ashtu::Parser.parse(text, dictionary:)` → `AST::Clause`.
- Validates: exactly 3 tokens, all words known, SVO part-of-speech order (noun/pronoun, verb, noun/pronoun).
- Added `parse` case in `CLI#run` and private `parse_sentence(args)` method with `-h`/`--help` support in `lib/ashtu/cli.rb`.
- Created `spec/ashtu/parser_spec.rb` with 8 tests covering happy path, unknown words, wrong token count, and wrong POS order.
- Ran `bundle exec rspec`: 36 examples, 0 failures.
- Manually verified: `./bin/ashtu parse "mi si dog"` → structured output; unknown word, wrong count, and `-h` all behave correctly.
- No issues encountered.

## 2026-05-17 (list_subcommand)

Completed `list_subcommand` task (status: ready → done_done).

- Added `Dictionary#list(pos: nil)` in `lib/ashtu/dictionary.rb`.
- Added `list` case in `CLI#run` and private `list(args)` method with `--pos` flag and `-h`/`--help` support in `lib/ashtu/cli.rb`.
- Added `rescue KeyError` in `format_entry` to gracefully handle TODO-section words with unmapped IPA characters.
- Updated help text to include `list` command.
- Added 3 tests for `Dictionary#list` in `spec/ashtu/dictionary_spec.rb` and 5 tests for CLI `list` in `spec/ashtu/cli_spec.rb`.
- Ran `bundle exec rspec`: 28 examples, 0 failures.
- Manually verified `./bin/ashtu list --pos verb`, `./bin/ashtu list -h`.
- No issues encountered.

## 2026-05-17 (ipa_cli_display)

Completed `ipa_cli_display` task (status: ready → done_done).

- Updated `CLI#format_entry` in `lib/ashtu/cli.rb` to call `IPA.call(entry.word)` and include `/ipa/` between POS tag and definition.
- Updated 2 tests in `spec/ashtu/cli_spec.rb` to expect the new format (lookup "dog" and search "fire").
- Ran `bundle exec rspec`: 20 examples, 0 failures.
- Manually verified: `./bin/ashtu lookup dog` → `dog [noun] /dog/ dog`; `./bin/ashtu search fire` → `faia [noun] /faia/ fire`.
- No issues encountered.

## 2026-05-17 (ipa_complete_mapping)

Completed `ipa_complete_mapping` task (status: ready → done_done).

- Audited `data/dictionary.txt` for all characters in non-comment, non-TODO word column.
- Added 10 missing characters to `CHARACTER_LOOKUP` in `lib/ashtu/ipa.rb`: `a`, `f`, `h`, `m`, `n`, `p`, `s`, `t`, `u`, `z`.
- Added 2 new tests in `spec/ashtu/ipa_spec.rb`: vowel mapping check and all-dictionary-chars smoke test.
- Ran `bundle exec rspec`: 20 examples, 0 failures.
- No issues encountered.

## 2026-05-17

Implemented `help_option` task (status: ready → done_done).

- Updated `lib/ashtu/cli.rb`: base `run` now handles `-h`/`--help` flags; `lookup` and `search` subcommands each show their own usage when called with `-h`, `--help`, or no arguments.
- Added 7 new tests in `spec/ashtu/cli_spec.rb` covering `-h`/`--help` for base, lookup, and search.
- Ran `bundle exec rspec`: 18 examples, 0 failures.
- Manually verified `./bin/ashtu --help`, `./bin/ashtu lookup --help`, `./bin/ashtu search -h` — all print correct usage text.
- No issues encountered.

Verified `dictionary_cli` task (status: done → done_done).

- Reviewed `lib/ashtu/dictionary.rb` (Dictionary class with `lookup` and `search`) and `lib/ashtu/cli.rb` (CLI with `lookup`/`search` subcommands).
- Ran `bundle exec rspec`: 11 examples, 0 failures.
- Ran `./bin/ashtu lookup dog` → `dog [noun] dog`.
- Ran `./bin/ashtu search fire` → `faia [noun] fire`, `smoke [noun] of fire`.
- No issues. All dictionary CLI functionality confirmed working.
