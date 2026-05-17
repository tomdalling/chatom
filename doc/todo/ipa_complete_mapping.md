---
status: done_done
---

Complete the IPA character mapping in `lib/ashtu/ipa.rb` so it covers every character
that appears in the dictionary (`data/dictionary.txt`).

## Current state

`Ashtu::IPA` has a `CHARACTER_LOOKUP` hash that currently only maps about 10 characters
(`d g i k l o b e r` and space). Calling `IPA.call` on most words raises `KeyError`.

## What to do

1. Audit `data/dictionary.txt` for every character used in the word column.
2. Add a mapping entry for each missing character. Use the Ashtu spelling rules
   (in the comment header of `dictionary.txt`) to guide the IPA assignment:
   - Vowels are already phonetic: `a` → /a/, `e` → /ɛ/, `i` → /i/, `o` → /o/, `u` → /u/
   - Consonants follow English values unless overridden by a spelling rule
   - `s` = /s/ (covers both original English /s/ and "sh" → /s/ words)
   - `d` = /d/ (covers both original /d/ and "th" → /d/ words)
   - `f` = /f/ (covers "ph" → /f/ words)
3. Cover the boundary characters too: space is already mapped.

## Acceptance criteria

- `IPA.call(word)` succeeds for every word in the non-comment, non-TODO section of
  `data/dictionary.txt` without raising.
- Existing tests in `spec/ashtu/ipa_spec.rb` still pass (and add tests for any new
  characters).
