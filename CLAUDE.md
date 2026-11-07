# Chatom

`chatom.md` is the canonical specification of the Chatom language and the single
source of truth for it. Its full text is imported below, so it is loaded into
every session. Consider it at all times, for every change to this repository.

@chatom.md

## Rules

1. **The spec is authoritative.** Everything in this repository (README,
   parser, dictionary, tests, examples, and anything added later) must conform
   to `chatom.md`.
2. **The spec wins conflicts.** If code, docs or a request conflicts with
   `chatom.md`, fix the non-spec side, or stop and ask the user. Never change the
   spec to fit code.
3. **The language changes only by explicit decision.** Edit the rules of the
   language in `chatom.md` only when the user explicitly asks for that change.
4. **Never invent answers to open items.** Anything marked **⚠ Not yet
   specified**, or listed in §22, is undecided. Do not guess. Flag it and ask
   the user. Code must treat it as unsupported until it is decided.

## Dictionary

`dictionary.sqlite` holds every Chatom word. Before reading or changing it, load
the `dictionary` skill (`.claude/skills/dictionary/SKILL.md`). Never write to
it without the user's explicit approval. Commit each approved change straight away,
without being asked (see the skill's "Committing" section).

## Editing `chatom.md`

After any edit to the spec, check every item:

1. **Appendix A** (words defined in the spec), **Appendix C** (grammar summary), the
   **Contents** list and **§22** (open items) still agree with the body text.
2. Every `§` cross-reference and anchor link still resolves, especially after
   renumbering.
3. Every new word (in examples or vocabulary) obeys the word-shape rules (§3)
   and the reserved beginnings (§3.2), and is not spelled like an
   existing function word (§6.3.3).
4. Every new example uses the three-line format (§1.2) and parses under
   Appendix C.
5. The change preserves both founding principles: every sentence has exactly
   one parse, and spelling is fully phonetic.

Match the spec's existing style: plain English for a reader with only a passing
interest in linguistics, technical terms explained on first use, "must" and
"may" as defined in §1.1, and short numbered rules.
