---
status: done_done
---

Fix the spelling of the ~20 words in the `# TODO: check/fix spelling` section of
`data/dictionary.txt` and promote them into the main dictionary.

## Why

These words still use English spelling, so `ashtu lookup` won't find them via Ashtu
spelling, and `IPA.call` will raise on characters not in the IPA map (e.g. `'c'`
in `"claw"`). The parser also can't use them.

## Ashtu spelling rules (from dictionary.txt header)

- No `c` — hard c → `k`, soft c → `s`
- No `y` — → `i`
- No `w` — → `u`
- No double letters — "kill" → "kil"
- Multi-letter sounds: `th` → `d`, `sh` → `s`, `ph` → `f`
- No silent letters or "weird" vowels — spell phonetically

## Words to fix

Apply the rules and pick phonetically faithful Ashtu spellings:

| English spelling | Suggested Ashtu spelling | Notes |
|---|---|---|
| claw | klo | 'aw' → 'o' (open-o sound) |
| foot | fut | 'oo' → 'u' |
| knee | ni | silent 'k', 'ee' → 'i' |
| hand | hand | already fine |
| belly | beli | no double-l, no 'y' |
| heart | hart | 'ea' → 'a' |
| liver | liver | already fine |
| drink | drink | already fine |
| know | no | silent 'k', 'ow' → 'o' |
| die | dai | 'ie' → 'ai' |
| fly | flai | 'y' → 'ai' (diphthong) |
| come | kum | 'c' → 'k', silent 'e' |
| lie | lai | 'ie' → 'ai' |
| stand | stand | already fine |
| give | giv | silent 'e' |
| stone | ston | silent 'e' |
| sand | sand | already fine |
| earth | erd | 'ear' → 'er', 'th' → 'd' |
| cloud | klaud | 'cl' → 'kl', 'ou' → 'au' |
| smoke | smok | silent 'e' |
| ash | as | 'sh' → 's' |
| name | naim | 'a_e' → 'ai' |

The suggested spellings above are a starting point — apply your own judgement
if the phonetics suggest something different.

## What to do

1. Remove the `# TODO: check/fix spelling` comment block.
2. Add each corrected entry to the main dictionary section (alphabetically or
   grouped with related words), following the existing format:
   `<ashtu_word> [<pos>] <english_definition>`
3. Preserve the existing English definitions.
4. Run `./bin/ashtu list` to verify all entries parse correctly.
5. Run the full test suite.

## Acceptance criteria

- No words remain in a `# TODO: check/fix spelling` section.
- `./bin/ashtu lookup as` returns the ash entry (or whatever spelling is chosen).
- `IPA.call` does not raise on any main-dictionary word.
- All tests pass.
