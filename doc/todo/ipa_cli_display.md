---
status: done_done
---

Show IPA pronunciation in CLI output for `lookup` and `search`.

## Prerequisite

`ipa_complete_mapping` task must be done first, otherwise `IPA.call` will raise on
most words.

## What to do

Update `CLI#format_entry` so output looks like:

```
dog [noun] /dɒg/ dog
faia [noun] /faɪa/ fire
```

The IPA string sits between the part-of-speech tag and the English definition.

1. Call `Ashtu::IPA.call(entry.word)` inside `format_entry`.
2. Wrap it in slashes: `"/#{ipa}/"`.
3. Update the relevant tests in `spec/ashtu/cli_spec.rb` to expect the new format.

## Acceptance criteria

- `./bin/ashtu lookup dog` output includes the IPA field.
- `./bin/ashtu search fire` output includes the IPA field for each result.
- All tests pass.
