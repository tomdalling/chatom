# Astu design session — saved state

Working notes from the design interview ("grilling") that produced `astu.md`.
Resume by running `/grilling` and pointing it at this file, e.g.
"continue the Astu design session from astu_design_session.md".

Last session: 2026-11-04. Questions are numbered globally (Q1, Q2, …); the next
new question is **Q148**.

## Ground rules agreed

- `astu.md` is a **standalone** spec, independent of every other file in this repo
  (old docs like `doc/decisions.md`, `doc/phonemes_and_graphemes.md` and
  `data/dictionary.txt` do not bind it; they were only used as sources for
  recommendations).
- The spec covers grammar and closed-class (function) words only. Nouns, verbs and
  adjectives live in a separate dictionary. A short non-normative sample
  vocabulary appendix is allowed for examples.
- Scope: full reference grammar (phonology, phonotactics, stress, orthography,
  morphology, word classes, NPs, VPs, clauses, questions, negation, commands,
  clause linking, comparison, numbers, pronouns, deixis, TAM, discourse, word
  formation, punctuation). Out of scope: culture, native script, history,
  dialects.
- Style: between a formal spec and a human-readable manual — strict definitions,
  approachable to non-linguists, glossed examples.
- Answer format: "Qn yes" accepts the recommendation (➡️).

## Decision log (settled)

| Q | Decision |
|---|---|
| Q1 | Engineered language: fully regular, unambiguous, machine-parseable. |
| Q2 | astu.md is standalone. |
| Q3 | No open-class words in the spec; dictionary is separate. |
| Q4 | Full reference grammar; exclude culture/script/history/dialects. |
| Q5 | Between formal spec and manual. |
| Q6 | Non-normative sample vocabulary appendix. |
| Q7 | Vowels a e i o u, no length, no tone (glides added by Q26). |
| Q8 | Consonants `p b t d k g f v s z sh ch m n l r w` (17). No h, y, zh, jh, nh. |
| Q9 | No strict CVC-alternation rule. |
| Q10 | Fixed stress on first syllable. |
| Q11 | Word class marked by first consonant. |
| Q12 | Analytic: no inflection, no articles. (Amended by Q79: class-changing prefixes are the one affix type.) |
| Q13 | Head-first everywhere, SVO. |
| Q14/Q15/Q49/Q57 | **Superseded by Q67**: verbs may have no object (no echo/dummy object). |
| Q16 | Open-class words start with a consonant; function words may start with a vowel. |
| Q17 + Q33 + Q40 | Word-internal syllables strictly C+nucleus; a word may end in one consonant. |
| Q18/Q41 | Final consonant may be any except `w`; no doubled consonants. |
| Q19 | Lowercase ASCII; `sh` and `ch` digraphs; alphabet `a b ch d e f g i k l m n o p r s sh t u v w z`. |
| Q20 | Open classes: noun, verb, adjective. Closed: function words. No adverbs. |
| Q21/Q29 | Optional TAM before first verb: bare = present/habitual, `bin` past, `fina` future, `am` progressive; `bin am`, `fina am`. |
| Q22 | Negation word `no`, before the verb group. |
| Q23 | Yes/no question = statement + final `no`. Wh-words in situ. |
| Q24 | Commands drop the subject. |
| Q25 | Serial verbs: S V1 O1 V2 O2…, shared subject, TAM/negation before V1 scopes over the chain. |
| Q26/Q42 | Any two different vowels may glide as one syllable (20 glides); max two vowels in a row; no identical pairs. |
| Q27 | Nouns start with stops `p b t d k g`; verbs with fricatives `f v s z sh ch`; adjectives with sonorants `m n l r w`. Function words exempt. |
| Q28 | Open-class words ≥ 2 syllables; function words may be 1 syllable. |
| Q29 | `be` = equative/identity copula; `fi` = possessive marker ("hand fi mi" = my hand). |
| Q30 | Final `no` is the sole exception to head-first; negative questions allowed. |
| Q31 | Prohibition = `no` + verb; no TAM in commands. |
| Q32/Q34/Q43 | Answers: `ie` yes, `no` no. |
| Q35 | Pre-verbal order: `no` → tense → aspect → verb, each at most once. |
| Q36 | `be` is a closed-class verb with all verb rules (TAM, negation, SVC). |
| Q37 | `be` may take a bare adjective as object ("dog be big"). |
| Q38 | `fi` phrase last in NP; everything after `fi` belongs to the possessor. |
| Q44–Q46 | Pronouns: 3 persons × sg/pl, no gender, single "we", one form for all roles. |
| Q47/Q52 | Plural pronouns are fused fixed words (singular + `dem`); nouns keep `dem` separate; singular pronouns end in a vowel. |
| Q48 | One reflexive "self" word for all persons (form not yet chosen). |
| Q50 | Wh-questions = general noun + "which?"; general nouns listed in spec. |
| Q51 | Function words obey shape rules except: may be vowel-initial, may be 1 syllable. |
| Q53–Q56/Q66 | `dem` plural marker; `mi` I, `iu` you, `dei` he/she/it; `midem`, `iudem`, `deidem`. |
| Q58 | No prepositions; roles expressed by core verbs in serial chains. |
| Q60 | Core verbs in spec (modals removed by Q74): use, give/to, for, go-to, come-from, be-at, be-with, pass (forms not yet chosen). Start with fricative, ≥ 2 syllables. |
| Q61 | NP order: head → describing nouns → adjectives → number → `dem` → demonstrative → "which?" → `fi` + possessor. (Relative clause slot removed by Q68.) |
| Q62 | Bare noun = singular; `dem` required for plural, even with a number. |
| Q63 | Repeating an adjective intensifies; any number of repetitions. |
| Q64 | `ia` this/near, `dea` that/far, after the noun. |
| Q65 | Base-10 numbers, digit words combined ("two ten three" = 23). |
| Q67 | Any verb may take or omit an object; no dictionary marking. |
| Q68 | No embedded clauses at all. Same-subject complements/purpose → serial verbs; otherwise separate clauses. |
| Q69 | Seven clause linkers (and, but, or, so, because, if, when), one between each pair of clauses, before the clause it introduces. |
| Q70 | Standalone `dea` refers back (incl. whole clauses); standalone `ia` refers forward. |
| Q71 | Final `no` questions the whole multi-clause sentence. |
| Q72 | Linkers never start a sentence; linked clause always second. |
| Q73 | No "and"/"or" words for nouns. |
| Q74 | Modals are NOT serial verbs: they have their own pre-verbal slot, like TAM markers. |
| Q76 | Quantifiers all/every/some/many/few/none in the number slot; `dem` required except after every/none (singular). "none" ≠ `no`. |
| Q77 | No ordinals (for now). |
| Q78 | Names have no marker and must obey all word rules (shape, first sound). |
| Q80 | No interjections; greetings are fixed phrases; spec lists a few. |
| Q81 | All lowercase, names too. Questions end `?`; shouted/exclaimed sentences `!`; all others `.`. No commas. Numbers may be written as digits. |
| Q82 | Function words unstressed; first-syllable stress for open-class words. |
| Q83 | `g` hard, `ch` church, `sh` ship, `s` never /z/, glides one smooth movement; `r` is the English r (not a tap). |
| Q84 | Object-less core verb "exist"; "have" is a dictionary verb. |
| Q85 | Claude proposes one full table of word forms; user edits line by line. |
| Q87 | Describing nouns nest: each narrows the word just before it. |
| Q88 | Numbers are a plain sequence of digit words, no powers (23 = two three). |
| Q89 | **Superseded by Q105**. |
| Q90 | `be` takes one or more adjectives; repetition intensifies there too. |
| Q91 | General nouns and core verbs obey the class rules (stop/fricative-initial, ≥2 syllables); `be` is the single listed exception. |
| Q92 | No discourse, topic, emphasis or politeness particles. |
| Q93 | Speech/thought/knowledge verbs take `ia` (forward) or `dea` (back); content is separate sentence(s); quotes optional. |
| Q94 | No "each other" word (for now). |
| Q75 | Comparison by "exceed" serial verb: `be lema fasi kati` (more than); `fasi oli` (most); core verb ⟨equal⟩ (as … as). Any quantifier may stand alone as an NP. |
| Q79 | No compounding, no general derivation — but class-changing prefixes exist (details Q110–Q113). |
| Q86 | Pronouns are ordinary nouns (all NP slots), except never take `dem` (fused plurals only). |
| Q95 | No noun-joining; spec documents idioms: repeat the clause, or ⟨be-with⟩ serial verb; "or" only between clauses. |
| Q96 | Pre-verbal order: `no` → tense → aspect → modal → verb chain. |
| Q97 | At most one modal per clause. |
| Q99 | Commands may take a modal (still no tense/aspect). |
| Q100 | `no` precedes and negates the modal; "must not" = `no` + can. |
| Q101 | Names are plain nouns (stop-initial, ≥2 syll, lowercase); no adaptation rule in spec. |
| Q102 | Every question ends `?` (shouted questions may end `?!`); non-shouted commands `.`; `!` purely tonal. |
| Q103 | `r` sounds like Australian English r (follow-up Q107 on non-rhotic final r). |
| Q104 | Digit sequences, no leading zeros except lone `ziro`, no fractions/decimals for now. |
| Q105 | Command clauses MAY be linked with non-command clauses (reverses Q89). |
| Q98 | Modals (closed list, function words): can, must, should, might. want/try/start/stop are ordinary verbs in serial chains (Q68). |
| Q107 | `r` may not be a final consonant (Australian non-rhotic); linker "or" becomes `ou`. |
| Q109 | A sentence containing a command can't be a question. |
| Q110 | **Forms superseded by Q146/Q147**: prefixes `pu-` (→noun), `vo-` (→verb), `ru-` (→adjective); no root begins with pu/vo/ru. |
| Q111 | pu+V act of V-ing; pu+A quality; vo+A make ADJ (no object: become); vo+N make into N (no object: become); ru+V tending to V; ru+N like N. Doers/tools/places via general noun + describing noun. |
| Q112 | Prefixes only on open-class words (incl. general nouns, core verbs) of another class; one per word; no stacking. |
| Q113 | Derived meanings always predictable; no idiomatic meanings. |
| Q114 | Word forms edited by the user in `word_forms.md`; Claude validates changes. |
| Q115 | In a mixed sentence, all command clauses come before all other clauses (Q108 resolved). |
| Q116 | No one-noun-phrase sentences. |
| Q117 | Number slot holds a number OR a quantifier, not both. |
| Q119 | No vocative construction. |
| Q120 | `ie.`/`no.` are the only non-clause sentences. |
| Q121 | **First-sound class rule dropped** (supersedes Q27 and the first-sound part of Q91): any open-class word may start with any consonant; class comes from the dictionary. Q16 (consonant-initial) still applies. Prefixes keep their forms (`pu-`, `vu-`, `ru-`) and stay reserved syllables. |
| Q122 | **2-syllable minimum dropped** (supersedes Q28 and the syllable part of Q91): open-class words may be 1 syllable. |
| Q123 | **Q16 dropped**: any word may start with a vowel. Vowels in adjacent words never glide together; they are pronounced separately. |
| Q124 | `tek` = core verb "take/use"; "take" removed from sample vocabulary. |
| Q126 | Remaining close pairs accepted as-is (incl. `wa`/`wan`). |
| Q125 | Sample "know" = `sabi`. |
| Q106 | Word forms final in `word_forms.md`. |
| Q118 | Spec documents idioms: ⟨be-at⟩ chain for time/place; `fori kozi wich` why; `vusa kaini wich` how; `sate pelis/temi wich` where/when. |
| Q127 | **Head-first dropped for noun phrases** (supersedes Q61 order and the head-first framing): NPs are head-last, English-like. Order: determiner (`ia`/`dea`/`wa`, or possessor + `fi`) → number/quantifier → adjectives → describing nouns → head → `dem`. Possessor precedes `fi` (`mi fi dag`), chains nest left; possessor excludes a demonstrative on the possessed noun. 2026-11-04. |
| Q128 | Copula renamed `be` → `bi`: phonetic spelling (/bi/), sounds like English "be". 2026-11-04. |
| Q129 | Possession by juxtaposition, pronouns only: a bare pronoun at the start of an NP (determiner slot) is the possessor (`mi buk` my book, `mi likil buk dem`). Pronouns are never describing nouns; pronoun heads take no describing nouns. 2026-11-04. |
| Q130 | Ownership is shown by `mi buk` (NP) or `buk fi mi.` (clause). |
| Q131 | `fi` is no longer an NP marker; it is a core verb "belong to / be for", replacing `fori` (`buk fi mi.` the book is mine; `mi kuk fish fi dei.` I cook fish for him; why = `fi wa rizon`). |
| Q132 | `sef` as possessor = "own" (refers to clause subject). |
| Q133 | Noun possessors: possessor NP + linking pronoun (`dei` sg / `deidem` pl) + possessed nominal (`dag dei eg` the dog's egg; `wa pasin dei dag` whose dog). Nests left; determiner belongs to the possessor. A possessor before `deidem` drops its `dem` (`dag deidem eg dem`) — exception to the always-`dem` rule. |
| Q134 | A pronoun-headed possessor must be a bare pronoun; "we two's book" → `buk fi tu midem.` |
| Q135 | A linking pronoun must always be followed by the possessed noun; "is the dog's" = `fi dag`. |
| Q136 | Core verb "be at" renamed `sidon` → `pon` (from pseudo-Jamaican "upon the" / "pon di"; `pondi` rejected because `nd` is a word-internal cluster). 2026-11-04. |
| Q137 | Pure rename: meaning (place and time) and gloss `be-at` unchanged; idioms become `pon wa pelaiz` where, `pon wa taim` when. |
| Q138 | The word's origin is recorded only here, not in astu.md (history out of scope, Q4). |
| Q139 | Prefix revision changes forms only; meanings, rules, stress and glosses (`N-` `V-` `A-`) unchanged. 2026-11-04. |
| Q140 | Markers stay prefixes (suffixes would clash with consonant-final and vowel-final roots). |
| Q141 | Each prefix is one CV syllable (nucleus may be a glide), with a second consonant-final form used before vowel-initial roots. |
| Q142 | Prefixes needn't be maximally distinct, but should make sense in pseudo-Jamaican creole and have a reason. |
| Q143 | Chosen mnemonically, in the pidgin-English style. |
| Q144 | No word of any class (root, function word, name) may begin with a prefix syllable. |
| Q145 | Vowel form = consonant form + one shared linking consonant that no open-class word may begin with (avoids `me`+`kot` vs `mek`+`ot` ambiguity). |
| Q146 | `di-` → noun (Jamaican *di* "the"), `me-` → verb (*mek* "make"), `lai-` → adjective ("like"). Risk noted: `me-` vs pronoun `mi`; stress distinguishes. |
| Q147 | Linking consonant `z`: vowel forms `diz-` `mez-` `laiz-`; no noun/verb/adjective may begin with `z` (function words like `ziro` exempt). Resolves the prefix + vowel-initial root issue. |

## Open questions (asked, not yet answered)

None. `astu.md` was rewritten on 2026-11-03 to match every decision above and
`word_forms.md`.

## Found while rewriting astu.md (not yet asked) — start the next round here

1. **Zero and plurality**: does a noun counted with `ziro` take `dem`?
   (Marked ⚠ in astu.md §19.)
2. **Greetings**: Claude added `mi luk iu.` (hello) and `mi fina luk iu.`
   (goodbye) to §21; confirm or replace, and decide whether to list more.
3. Still deferred by user: "each other" (Q94), ordinals (Q77),
   fractions/decimals (Q104).

## Issues found while writing astu.md (all since resolved: Q86–Q93, Q106)

These came up while drafting and should go on the frontier next session:

1. **Pronouns inside noun phrases**: may a pronoun be followed by modifiers
   (`midem tu dem`, "we two")? May a pronoun be a describing noun? Current draft
   grammar treats a pronoun as a complete NP on its own (except as possessor
   after `fi`).
2. **Multiple describing nouns**: in `head N1 N2`, does N2 describe the head or N1?
   (Draft says only that adjectives describe the head.)
3. **Large numbers**: words for 100, 1000, zero; exact composition rule
   (is 23 "two ten three"; is 10 "ten" or "one ten"?).
4. **Commands in linked clauses**: may the clause after a linker be a command
   (`... [and] zita pisa`)? Could a subjectless second clause be confused with a
   serial verb continuing the previous clause? (It can't — a linker always
   intervenes — but whether it's allowed is undecided.)
5. **`be` + several adjectives**: draft grammar allows `be adjective+`; confirm
   that, and whether repetition-intensifying works there (`dogo be lema lema`).
6. **General nouns and core verbs as function words**: they behave as nouns/verbs
   grammatically but are exempt from the first-sound rule. Should they instead be
   required to obey it (core verbs were already specified as fricative-initial,
   ≥ 2 syllables)? Decide the same for general nouns.
7. **Sample vocabulary**: the provisional words in astu.md Appendix B
   (`dogo`, `pisa`, `zita`, `lema`, …) were invented by Claude to make examples
   readable; confirm or replace them as part of Q85.
8. **Discourse particles / politeness** (please, topic markers, emphasis) — not
   yet discussed.
9. **Quoted speech** ("he said: …") with no embedded clauses — presumably
   `dei [say] ia. …` using forward-referring `ia`; not yet confirmed.

## Pending word forms

Placeholders used in astu.md that need actual words:
`⟨self⟩`, `⟨which⟩`, `⟨person⟩`, `⟨thing⟩`, `⟨place⟩`, `⟨time⟩`, `⟨reason⟩`,
`⟨way⟩`, `⟨amount⟩`, `⟨use⟩`, `⟨give⟩`, `⟨for⟩`, `⟨go-to⟩`, `⟨come-from⟩`,
`⟨be-at⟩`, `⟨be-with⟩`, `⟨pass⟩`, `⟨and⟩`, `⟨but⟩`, `⟨or⟩`, `⟨so⟩`,
`⟨because⟩`, `⟨if⟩`, `⟨when⟩`, digits 0–9, ten (and higher powers), plus
whatever Q73–Q84 add (noun-and, noun-or, modals, equal, exist, quantifiers,
ordinal marker, name marker).
