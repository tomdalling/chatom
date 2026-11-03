# Astu

**Astu** is a constructed language designed to be completely regular and
unambiguous. Its two founding principles are:

1. **Unambiguous structure.** Any valid Astu sentence can be broken down into
   exactly one grammatical structure. A computer can parse it without guessing,
   and a learner never has to wonder which word goes with which.
2. **Phonetic spelling.** Each sound is written exactly one way, and each
   spelling is pronounced exactly one way. If you can read a word, you can say
   it; if you can hear a word, you can spell it.

This document is the complete specification of the grammar and of every
function word. It is meant to be precise enough to build software from, while
remaining readable for someone with only a passing interest in linguistics.
Technical terms are explained when they first appear.

> **Status: draft.** A few small parts of the language are not yet decided.
> They are marked **⚠ Not yet specified** and collected in
> [§22](#22-not-yet-specified).

## Contents

1. [Conventions used in this document](#1-conventions-used-in-this-document)
2. [Sounds](#2-sounds)
3. [Word shape](#3-word-shape)
4. [Stress](#4-stress)
5. [Writing](#5-writing)
6. [Word classes](#6-word-classes)
7. [Pronouns](#7-pronouns)
8. [Noun phrases](#8-noun-phrases)
9. [Clauses](#9-clauses)
10. [Tense, aspect and modality](#10-tense-aspect-and-modality)
11. [Negation](#11-negation)
12. [The copula `bi` and existence](#12-the-copula-bi-and-existence)
13. [Serial verbs](#13-serial-verbs)
14. [Comparison](#14-comparison)
15. [Questions](#15-questions)
16. [Commands](#16-commands)
17. [Sentences with several clauses](#17-sentences-with-several-clauses)
18. [Reported speech and thought](#18-reported-speech-and-thought)
19. [Numbers and quantifiers](#19-numbers-and-quantifiers)
20. [Making new words](#20-making-new-words)
21. [Fixed phrases](#21-fixed-phrases)
22. [Not yet specified](#22-not-yet-specified)
23. [Appendix A: Function word list](#appendix-a-function-word-list)
24. [Appendix B: Sample vocabulary (non-normative)](#appendix-b-sample-vocabulary-non-normative)
25. [Appendix C: Grammar summary](#appendix-c-grammar-summary)

---

## 1. Conventions used in this document

**1.1 Normative language.** "Must" and "must not" state absolute rules of the
language. "May" states something that is allowed but optional.

**1.2 Examples.** Examples are given in three lines: the Astu sentence, a
word-by-word gloss, and an English translation in quotes.

```
mi  niam  fish.
I   eat   fish
```
"I eat fish."

**1.3 Gloss abbreviations.** Grammatical words are glossed in capitals:

| Abbreviation | Meaning |
|---|---|
| `NEG` | negation (`no`) |
| `PST` | past tense (`bin`) |
| `FUT` | future tense (`fina`) |
| `PROG` | progressive aspect (`am`) |
| `COP` | copula (`bi`) |
| `PL` | plural marker (`dem`) |
| `PROX` | near demonstrative, "this" (`ia`) |
| `DIST` | far demonstrative, "that" (`dea`) |
| `Q` | yes/no question marker (sentence-final `no`) |
| `N-` `V-` `A-` | noun-, verb- and adjective-making prefixes (`di-`, `me-`, `lai-`) |

All other words are glossed with their English meaning. A pronoun used as a
possessor ([§8.8](#88-possession)) is glossed with the English possessive:
`mi` as "my", `dei` as "his", `deidem` as "their".

**1.4 Sample vocabulary.** Most nouns, verbs and adjectives are not part of
this specification (see [§6](#6-word-classes)). The examples borrow words from
the non-normative sample vocabulary in
[Appendix B](#appendix-b-sample-vocabulary-non-normative).

---

## 2. Sounds

Astu has **5 vowels** and **17 consonants**: 22 sounds in total. It has no tone,
and the length of a sound never changes the meaning of a word.

### 2.1 Vowels

The vowels are close to those of Japanese or Spanish: short and "pure", meaning
the sound does not shift while it is held.

| Letter | IPA | As in |
|---|---|---|
| `a` | /a/ | f**a**ther (but short) |
| `e` | /e/ | b**e**t |
| `i` | /i/ | mach**i**ne |
| `o` | /o/ | f**o**rk (but short) |
| `u` | /u/ | r**u**le |

**2.1.1** Astu has no long vowels. A doubled vowel such as `aa` must not occur.

### 2.2 Vowel glides

**2.2.1** Two *different* vowels may stand side by side inside a word. When
they do, they are pronounced together as a single syllable, in one smooth
movement from the first vowel to the second. A pair like this is called a
**glide** (or diphthong).

```
dei    = one syllable: d + ei
iu     = one syllable: iu
deidem = two syllables: dei · dem
```

**2.2.2** Every ordered pair of two different vowels is a valid glide. That
gives 20 glides:

| | +a | +e | +i | +o | +u |
|---|---|---|---|---|---|
| **a+** | — | ae | ai | ao | au |
| **e+** | ea | — | ei | eo | eu |
| **i+** | ia | ie | — | io | iu |
| **o+** | oa | oe | oi | — | ou |
| **u+** | ua | ue | ui | uo | — |

**2.2.3** No more than two vowels may stand side by side within a word. A
sequence such as `aia` must not occur. This keeps syllable boundaries
unambiguous.

**2.2.4 Vowels across word boundaries.** Glides only happen *inside* a word.
When one word ends in a vowel and the next begins with one, the two vowels are
pronounced separately, never as a glide. In `mi abi`, the `i` and the `a`
belong to different syllables: *mi · a · bi*, never *mia · bi*.

### 2.3 Consonants

| Letter | IPA | As in |
|---|---|---|
| `p` | /p/ | **p**en |
| `b` | /b/ | **b**ed |
| `t` | /t/ | **t**op |
| `d` | /d/ | **d**og |
| `k` | /k/ | **k**ite |
| `g` | /g/ | **g**o |
| `f` | /f/ | **f**an |
| `v` | /v/ | **v**an |
| `s` | /s/ | **s**un |
| `z` | /z/ | **z**oo |
| `sh` | /ʃ/ | **sh**ip |
| `ch` | /tʃ/ | **ch**urch |
| `m` | /m/ | **m**an |
| `n` | /n/ | **n**o |
| `l` | /l/ | **l**eg |
| `r` | /ɹ/ | **r**ed, as said in Australian English |
| `w` | /w/ | **w**et |

**2.3.1 Pronunciation details.**

- `r` is the English `r` as pronounced in Australian English: the tongue
  approaches the roof of the mouth without touching it. It is never tapped or
  trilled. Because `r` can never end a word ([§3.1.3](#31-syllables)) and two
  consonants never touch inside a word, `r` is always followed by a vowel, so
  it is always pronounced.
- `g` is always "hard", as in **g**o, never as in **g**em.
- `s` is always /s/, as in **s**un. It is never voiced to /z/, even between
  vowels: `pasin` is *pa-sin*, never *pa-zin*.
- `sh` is always /ʃ/ as in **sh**ip, and `ch` is always /tʃ/ as in **ch**urch.

**2.3.2** Astu has no sound /h/, no "y" sound /j/, and none of the sounds
/ʒ/ (as in mea**s**ure), /dʒ/ (as in **j**am) or /ŋ/ (as in si**ng**).

---

## 3. Word shape

### 3.1 Syllables

**3.1.1** The vowel or glide at the heart of a syllable is called its
**nucleus**. A nucleus is either a single vowel or a glide.

**3.1.2** A word may begin with a vowel or with a consonant. After the first
nucleus, every syllable is exactly **one consonant followed by one nucleus**.
Two consonants never stand side by side within a word.

**3.1.3** The **last** syllable of a word may also end in one consonant. That
final consonant may be any consonant except `w` and `r`. A final `w` would
sound like the glide `au` or `ou`, and a final `r` is silent in Australian
English, so `kar` would sound like `ka`.

```
pa · sin      valid: final consonant n
fish          valid: one syllable, final consonant sh
a · bi        valid: begins with a vowel
kiat          valid: glide ia, final consonant t
pan · tu      invalid: two consonants inside the word (n t)
dagw          invalid: ends in w
kar           invalid: ends in r
```

**3.1.4** Because two consonants never touch inside a word, doubled consonants
such as `tt` or `nn` cannot occur.

**3.1.5** A word may be any number of syllables long, including one.

### 3.2 Reserved first syllables

**3.2.1** The syllables `di`, `me` and `lai` are reserved for the word-making
prefixes ([§20](#20-making-new-words)). No other word may begin with them:
not a root, not a function word, not a name. A word that begins with `di`,
`me` or `lai` is therefore always a prefix followed by a root.

**3.2.2** No noun, verb or adjective may begin with `z`. Function words, such
as `ziro`, may. This lets each prefix take a linking `z` before a root that
begins with a vowel ([§20.2](#20-making-new-words)).

### 3.3 Formal definition

The table below states the shape rules as patterns. In each pattern, `?` means
"optional" and `( )*` means "zero or more times".

| Symbol | Means |
|---|---|
| `C` | any consonant |
| `F` | any consonant except `w` and `r` (allowed as a final consonant) |
| `N` | a nucleus: one vowel, or two different vowels |

| Word type | Pattern |
|---|---|
| Any word | `C? N (C N)* F?` |
| Function word | as above, and not beginning with `di`, `me` or `lai` |
| Root word | as above, and not beginning with `di`, `me`, `lai` or `z` |
| Prefixed word | `di`, `me` or `lai`, then a root beginning with a consonant; or `diz`, `mez` or `laiz`, then a root beginning with a vowel |

A consequence of this pattern is that splitting a word into syllables is
always unambiguous. A new syllable begins at every consonant, except a
consonant at the very end of the word, which belongs to the last syllable.

---

## 4. Stress

**4.1** In nouns, verbs and adjectives, stress always falls on the **first
syllable**. In a word built with a prefix ([§20](#20-making-new-words)), the
prefix is the first syllable, so it carries the stress.

**4.2** Function words are **unstressed** in normal speech.

**4.3** Stress is never written, and it never changes the meaning of a word.

```
PA·sin   SE·liep   LI·kil   DI·niam
```

---

## 5. Writing

### 5.1 The alphabet

Astu is written in the basic Latin alphabet (plain ASCII, with no accents). It
uses 22 letters or letter pairs, one for each sound:

```
a  b  ch  d  e  f  g  i  k  l  m  n  o  p  r  s  sh  t  u  v  w  z
```

**5.1.1** The letters `c`, `h`, `j`, `q`, `x` and `y` are never used on their
own.

**5.1.2** `sh` and `ch` are each a single sound written with two letters.
Because `h` never appears on its own, they can never be misread: `s` followed
by `h` is always /ʃ/, and `c` only ever appears as part of `ch`.

**5.1.3** Words are separated by spaces.

**5.1.4** Everything is written in **lowercase**, including names and the first
word of a sentence.

### 5.2 Punctuation

**5.2.1** Every sentence ends with exactly one of these marks:

| Mark | Used for |
|---|---|
| `?` | every question ([§15](#15-questions)) |
| `?!` | a shouted or exclaimed question |
| `!` | any other shouted or exclaimed sentence |
| `.` | every other sentence, including ordinary commands |

**5.2.2** Punctuation never changes the grammar. A question is a question
because of its words (a final `no` or the question word `wa`), not because of
its `?`. The `!` shows only tone of voice.

**5.2.3** Astu uses **no commas**. Clause boundaries are always marked by
linking words ([§17](#17-sentences-with-several-clauses)).

**5.2.4** Quoted words may be put in quotation marks (`"…"`) to make writing
easier to read ([§18](#18-reported-speech-and-thought)). Quotation marks are
optional.

**5.2.5 Digits.** Numbers may be written with the digits `0`–`9` instead of
number words. Each digit stands for its digit word
([§19](#19-numbers-and-quantifiers)): `23` is read `tu tiri`.

---

## 6. Word classes

### 6.1 Open and closed classes

Astu has three **open classes** of words and one **closed class**.

| Class | Open or closed | Where its words are listed |
|---|---|---|
| Noun | open | the Astu dictionary |
| Verb | open | the Astu dictionary |
| Adjective | open | the Astu dictionary |
| Function word | closed | this specification ([Appendix A](#appendix-a-function-word-list)) |

**6.1.1** An **open class** can gain new words at any time. Its words are listed
in a separate dictionary and are not part of this specification.

**6.1.2** The **closed class** of function words is fixed. Every function word is
defined in this specification. Function words include pronouns, grammatical
markers, modals, linking words, quantifiers, digit words and prefixes.

**6.1.3** This specification also defines a small, fixed set of **general
nouns** ([§15.2](#152-question-word-questions)) and **core verbs**
([§9.3](#93-no-prepositions)). Grammatically they are ordinary nouns and verbs,
but because the grammar depends on them, they are listed here rather than in
the dictionary.

**6.1.4** Astu has **no adverbs**. Meanings that other languages express with
adverbs are expressed with serial verbs ([§13](#13-serial-verbs)) or with
function words.

### 6.2 No inflection

**6.2.1** Astu is an **analytic** language. Words never change form to show
grammar: there are no endings, no agreement and no irregular forms. Grammar is
expressed entirely through word order and function words.

**6.2.2** The only way to build one word from another is with the three
class-changing prefixes ([§20](#20-making-new-words)). A prefixed word is a new
word in its own right, not a different form of the old one.

**6.2.3** Astu has no articles ("a", "the").

**6.2.4** Astu has no interjections. Greetings and similar expressions are
fixed phrases built from ordinary sentences ([§21](#21-fixed-phrases)).

### 6.3 Identifying a word's class

**6.3.1** A word's form says nothing about its class. Any word may begin with
any sound.

**6.3.2** To find the class of a word:

1. If it is in the function word list ([Appendix A](#appendix-a-function-word-list)),
   it is that function word.
2. If it begins with `di`, `me` or `lai`, it is a prefixed word, and the prefix
   gives its class ([§20](#20-making-new-words)).
3. Otherwise, look it up in the dictionary.

**6.3.3** No noun, verb or adjective may be spelled the same as a function word.

---

## 7. Pronouns

**7.1** Astu has six personal pronouns, distinguished by **person** (I / you /
he·she·it) and **number** (one / more than one).

| | Singular | Plural |
|---|---|---|
| 1st person | `mi` I, me | `midem` we, us |
| 2nd person | `iu` you | `iudem` you (all) |
| 3rd person | `dei` he, him, she, her, it | `deidem` they, them |

**7.2** Pronouns have no gender. `dei` covers "he", "she" and "it".

**7.3** There is only one "we". It does not distinguish "we, including you" from
"we, not including you".

**7.4** A pronoun has a single form. The same word is used as the subject, the
object and the possessor.

```
mi  luk  dei.        dei  luk  mi.
I   see  him         he   sees me
```
"I see him." / "He sees me."

**7.5** The plural pronouns are fixed words, formed historically by fusing a
singular pronoun with the plural marker `dem`. This fusion happens **only** in
the three plural pronouns. It is not a general rule: nouns never fuse with
`dem` (see [§8.5](#85-plural)).

**7.6** Because of 7.5, every singular pronoun ends in a vowel. If one ended in a
consonant, fusing it with `dem` would put two consonants side by side inside a
word, which [§3.1.2](#31-syllables) forbids.

**7.7 Reflexive.** Astu has a single reflexive pronoun, `sef`, used for every
person and number. It is used when the object is the same as the subject.

```
dei  luk  sef.
he   sees self
```
"He sees himself."

Compare `dei luk dei.`, which means "he sees him", where "him" is someone else.

**7.8 Pronouns are nouns.** Grammatically, a pronoun is a noun, and it may be
the head of a noun phrase or a possessor ([§8.10](#810-pronouns-in-noun-phrases)).
A pronoun never takes the plural marker `dem`: plurality is shown only by the
plural pronouns. A pronoun is never a describing noun.

> ⚠ **Not yet specified:** a word for "each other".

---

## 8. Noun phrases

A **noun phrase** is a noun together with any words that describe it, such as
"those two small bird eggs".

### 8.1 The head comes last

**8.1.1** In a noun phrase, the main word (its **head**) comes **last**.
Everything that describes it comes before it, much as in English. The only word
that may follow the head is the plural marker `dem`.

### 8.2 Order of a noun phrase

**8.2.1** A noun phrase must follow this fixed order. Every part except the head
is optional.

| # | Part | Example |
|---|---|---|
| 1 | Determiner: a demonstrative (`ia` / `dea`), the question word `wa`, a possessive pronoun, **or** a possessor + linking pronoun ([§8.8](#88-possession)) | `dea` that |
| 2 | Number **or** quantifier | `tu` two |
| 3 | Adjectives | `likil` small |
| 4 | Describing nouns | `bad` bird |
| 5 | Head noun | `eg` egg |
| 6 | Plural marker `dem` | `dem` |

```
dea   tu   likil  bad   eg   dem
DIST  two  small  bird  egg  PL
```
"those two small bird eggs"

```
mi  tu   likil  bad   eg   dem
my  two  small  bird  egg  PL
```
"my two small bird eggs"

**8.2.2** A noun phrase has at most one determiner. A demonstrative, `wa` and
a possessor cannot be combined, so there is no direct equivalent of "those eggs
of mine" ([§8.8.6](#88-possession)).

### 8.3 Describing nouns

**8.3.1** A **describing noun** comes before the head and narrows down what kind
of thing it is, exactly like the first noun in English "bird egg".

```
bad   eg
bird  egg
```
"bird egg"

**8.3.2 Several describing nouns.** When there is more than one describing
noun, each one narrows down **the word directly after it**. The phrase is
read as a nested chain from the left.

```
dag  diseliep  pelais
dog  N-sleep   place
```
"dog-sleeping place", that is, a kennel. `dag` narrows down `diseliep`
("dog-sleeping"), and `dag diseliep` narrows down `pelais`.

**8.3.3** Because describing nouns and the head are all nouns, the head is
always the **last** noun in the run. A noun phrase never ends with a describing
noun.

### 8.4 Adjectives

**8.4.1** Adjectives come before any describing nouns and the head noun. They
always describe the **head** noun, never a describing noun.

```
likil  bad   eg
small  bird  egg
```
"small bird egg": the egg is small, not the bird. Unlike English, this is never
ambiguous.

**8.4.2** Adjectives have no fixed order among themselves.

**8.4.3 Intensifying by repetition.** Repeating an adjective strengthens it. Each
extra repetition adds more intensity. There is no limit on the number of
repetitions.

```
big  dag                a big dog
big  big  dag           a very big dog
big  big  big  dag      an extremely big dog
```

### 8.5 Plural

**8.5.1** A noun with no plural marker is **singular**: `dag` means exactly one
dog.

**8.5.2** The plural marker `dem` comes directly after the head noun, like the
English "-s". It must be used whenever there is more than one. This applies even
when a number makes the amount obvious. The one exception is a possessor
followed by `deidem` ([§8.8.5](#88-possession)).

```
dag  dem          tu   dag  dem
dog  PL           two  dog  PL
```
"dogs" / "two dogs"

**8.5.3** The quantifiers `eri` ("every") and `notin` ("none") take a singular
noun, so they are never followed by `dem` ([§19.3](#193-quantifiers)).

### 8.6 Demonstratives: `ia` and `dea`

**8.6.1** `ia` means "this" (near), and `dea` means "that" (far). They fill the
determiner slot at the start of the noun phrase.

```
ia    dag           dea   dag  dem
PROX  dog           DIST  dog  PL
```
"this dog" / "those dogs"

### 8.7 The question word `wa`

**8.7.1** `wa` means "which?". It fills the determiner slot at the start of the
noun phrase. A noun phrase containing `wa` makes its sentence a question
([§15.2](#152-question-word-questions)).

```
wa     big  dag
which  big  dog
```
"which big dog?"

### 8.8 Possession

Astu has no possessive marker. A possessor (the owner) is shown by its
position at the start of the noun phrase, in one of two ways.

**8.8.1 Pronoun possessors.** A bare pronoun placed at the start of a noun
phrase is the **possessor** of the head. It fills the determiner slot, so it
comes before any number, quantifier or adjective.

```
mi  buk          dei  tu   likil  dag  dem
my  book         his  two  small  dog  PL
```
"my book" / "his two small dogs"

**8.8.2** A possessive pronoun must be **bare**: it must not have its own
number, quantifier or adjectives. A possessor such as "we two" is expressed
with a clause instead ([§8.8.10](#88-possession)): `buk fi tu midem.` "The book
belongs to us two."

**8.8.3 "Own": `sef`.** The reflexive `sef` ([§7.7](#7-pronouns)) may be a
possessor. It refers to the subject of the clause, like English "own".

```
dei  luk  sef  buk.           dei  luk  dei  buk.
he   sees own  book           he   sees his  book
```
"He sees his own book." / "He sees his book" (someone else's).

**8.8.4 Noun possessors.** Any other possessor is a full noun phrase,
followed by a **linking pronoun**, followed by the thing owned. The linking
pronoun is `dei` if the possessor is singular and `deidem` if it is plural, much
like English "the dog his egg".

```
dag  dei  eg                  dag  deidem  eg   dem
dog  his  egg                 dog  their   egg  PL
```
"the dog's egg" / "the dogs' eggs"

**8.8.5 No double plural.** A possessor followed by `deidem` never takes `dem`,
because `deidem` already shows that it is plural. This is the one exception to
[§8.5.2](#85-plural).

```
tu   dag  deidem  eg   dem
two  dog  their   egg  PL
```
"the two dogs' eggs"

**8.8.6** Everything before the linking pronoun, back to the start of the noun
phrase, belongs to the possessor. Everything after it describes the thing
owned. In particular, a demonstrative or `wa` at the start of the noun phrase
always belongs to the possessor.

```
dea   big  dag  dei  likil  eg          wa     pasin   dei  dag
DIST  big  dog  his  small  egg         which  person  his  dog
```
"that big dog's small egg" / "whose dog?"

The thing owned can never take its own determiner. "Those eggs of mine" is
expressed as "my eggs" or with a separate sentence.

**8.8.7 Chains.** Because the possessor is itself a noun phrase, it may contain
its own possessor. Possession chains are read from left to right, as in
English.

```
mi  dag  dei  eg
my  dog  his  egg
```
"my dog's egg": `mi dag` ("my dog") is the possessor of `eg`.

**8.8.8** A standalone `ia`, `dea` or quantifier ([§8.9](#89-noun-phrases-with-no-head-noun))
may be a noun possessor:

```
dea  dei  eg                  al   deidem  dag  dem
DIST his  egg                 all  their   dog  PL
```
"that one's egg" / "everyone's dogs"

**8.8.9 Rules for linking pronouns.**

- A linking pronoun must always be followed by the thing owned. A noun phrase
  never ends with a linking pronoun.
- The possessor before a linking pronoun must not have a pronoun as its head.
  A pronoun possessor is always a bare pronoun, used as in 8.8.1.
- The head of the thing owned must be a noun, not a pronoun.

These rules keep possession unambiguous. Two noun phrases never stand side by
side, and a pronoun is never a describing noun ([§8.10](#810-pronouns-in-noun-phrases)).
So inside a noun phrase, a bare pronoun at the start that is followed by more
of the noun phrase is always a possessor, and a pronoun directly after a
possessor is always a linking pronoun.

**8.8.10 Ownership as a statement.** To *say* that something belongs to
someone, use the core verb `fi` ("belong to", [§9.3](#93-no-prepositions)):

```
buk   fi           mi.
book  belongs-to   me
```
"The book is mine."

### 8.9 Noun phrases with no head noun

**8.9.1** Three kinds of word may stand alone as a complete noun phrase, with
no head noun. Nothing may follow them except a linking pronoun
([§8.8.8](#88-possession)):

- `dea`, which refers **back** to something already said, including a whole
  previous clause or sentence;
- `ia`, which refers **forward** to something about to be said;
- any quantifier ([§19.3](#193-quantifiers)), meaning that amount of the people
  or things being talked about.

```
iu   niam  fish.   mi  sabi  dea.
you  eat   fish    I   know  DIST
```
"You eat fish. I know that."

```
ia    dag  bi   big  pas   al.
PROX  dog  COP  big  pass  all
```
"This dog is the biggest." (literally "this dog is big, surpassing all")

### 8.10 Pronouns in noun phrases

**8.10.1** A pronoun is a noun ([§7.8](#7-pronouns)), so it may be the head of a
noun phrase and take any of the parts in [§8.2](#82-order-of-a-noun-phrase),
**except** describing nouns and `dem`.

```
tu   midem        al   deidem        tiad   mi
two  we           all  they          tired  I
```
"we two" / "all of them" / "tired me"

**8.10.2** A number or quantifier meaning more than one is used only with a
plural pronoun, in the same way that a plural number needs `dem` after a noun.

**8.10.3** A pronoun is never a describing noun. A bare pronoun directly before
the rest of a noun phrase is always its possessor ([§8.8.1](#88-possession)):
`mi buk` means "my book".

### 8.11 No joined noun phrases

**8.11.1** Astu has no words for "and" or "or" between noun phrases. Instead:

- **Repeat the clause**, joined with a linking word
  ([§17](#17-sentences-with-several-clauses)):

  ```
  dag  niam  fish  an   kiat  niam  fish.
  dog  eats  fish  and  cat   eats  fish
  ```
  "The dog and the cat eat fish."

- **Use the core verb `wid`** ("be with") in a serial verb chain
  ([§13](#13-serial-verbs)):

  ```
  dag  wid      kiat  niam  fish.
  dog  be-with  cat   eat   fish
  ```
  "The dog eats fish with the cat."

- **"Or"** can only join whole clauses:

  ```
  iu   niam  fish  ou  iu   niam  bared?
  you  eat   fish  or  you  eat   bread
  ```
  "Do you eat fish or bread?"

---

## 9. Clauses

A **clause** is a single statement of "who does what (to what)", like "the dog
eats fish".

### 9.1 Word order

**9.1.1** A clause has the order **subject – verb – object** (SVO).

```
dag  niam  fish.
dog  eats  fish
```
"The dog eats the fish."

### 9.2 Objects are optional

**9.2.1** Every verb may be used with an object or without one. The dictionary
does not record which verbs take objects.

```
mi  niam.            mi  niam  fish.
I   eat              I   eat   fish
```
"I eat." / "I eat fish."

```
dag  seliep.
dog  sleeps
```
"The dog sleeps."

**9.2.2** This never makes a sentence ambiguous. A verb is followed by an object
only if the next word can begin a noun phrase (a noun, a pronoun, an adjective,
a number, a quantifier, `ia`, `dea` or `wa`). If the next word is a verb, a linking
word, the question marker or the end of the sentence, the verb has no object.

### 9.3 No prepositions

**9.3.1** Astu has **no prepositions** (words like "in", "with", "to", "for").
Relationships such as instrument, recipient, location and direction are
expressed with **core verbs** in a serial verb chain ([§13](#13-serial-verbs)).

**9.3.2** The core verbs are a small, fixed set of verbs defined in this
specification. Apart from being listed here, they are ordinary verbs.

| Word | Meaning | Role it expresses |
|---|---|---|
| `tek` | take, use | instrument ("with a knife") |
| `gib` | give | recipient ("to him") |
| `fi` | belong to, be for | owner ("is his") and beneficiary or purpose ("for him") |
| `guan` | go to | direction ("to the house") |
| `kum` | come from | source ("from the house") |
| `pon` | be at | location and time ("in the house", "at noon") |
| `wid` | be with | accompaniment ("with him") |
| `pas` | pass, exceed | comparison ("more than"), [§14](#14-comparison) |
| `siem` | equal | comparison ("as … as"), [§14](#14-comparison) |
| `abi` | exist | existence ("there is"), [§12.3](#123-existence-abi) |

```
mi  tek  naif   kot  bared.
I   use  knife  cut  bread
```
"I cut the bread with a knife."

```
mi  tek   fish  gib   dei.
I   take  fish  give  him
```
"I give the fish to him."

```
mi  kuk   fish  fi   dei.
I   cook  fish  for  him
```
"I cook fish for him."

### 9.4 No embedded clauses

**9.4.1** Astu has **no embedded clauses**. A clause can never appear inside
another clause, and a clause can never take the place of a noun phrase. There
is no equivalent of English "that", "who" or "which" introducing a clause.

**9.4.2** Meanings that other languages express with embedded clauses are
expressed in one of two ways:

- **Serial verbs.** Use these when the two actions share a subject: "I want to
  eat fish", or "I went to buy food". See [§13](#13-serial-verbs).
- **Separate clauses.** Use these for everything else. The second clause refers
  back with a pronoun, a demonstrative, or a repeated noun.

| English | Astu approach |
|---|---|
| "I know *that you ate fish*." | "You ate fish. I know that." (see [§18](#18-reported-speech-and-thought)) |
| "The dog *that ate the fish* is sick." | "A dog ate fish. That dog is sick." |
| "I slept *because you ate*." | "I slept `kaz` you ate." (see [§17](#17-sentences-with-several-clauses)) |

```
dag  bin  niam  fish.   dea   dag  bi   sik.
dog  PST  eat   fish    DIST  dog  COP  sick
```
"A dog ate the fish. That dog is sick." That is: "The dog that ate the fish is sick."

### 9.5 Every sentence is a clause

**9.5.1** Every sentence must contain at least one full clause. A noun phrase on
its own is not a sentence: not as an answer, not as an exclamation, and not to
call someone by name.

**9.5.2** The only exceptions are the answers `ie.` ("yes") and `no.` ("no"),
which may stand alone ([§15.3](#153-answering-yesno-questions)).

**9.5.3** Astu has no vocative (a way of calling someone by name, as in
"Sara, look!"). Who is being spoken to is understood from context.

---

## 10. Tense, aspect and modality

**10.1** Tense (when something happens), aspect (how it unfolds over time) and
modality (ability, necessity and possibility) are **optional**. They are shown
by function words placed directly before the first verb of the clause.

### 10.2 Tense and aspect

| Marker | Meaning | Gloss |
|---|---|---|
| *(none)* | present or habitual: "eats", "is eating" or "eats regularly", with the time taken from context | |
| `bin` | past | `PST` |
| `fina` | future | `FUT` |
| `am` | progressive: an action in progress, "is …ing" | `PROG` |

**10.2.1** One tense marker may combine with `am`:

| Combination | Meaning |
|---|---|
| `bin am` | past progressive: "was …ing" |
| `fina am` | future progressive: "will be …ing" |

### 10.3 Modals

**10.3.1** Astu has four **modals**:

| Modal | Meaning |
|---|---|
| `kian` | can, may, is able to, is allowed to |
| `mos` | must, has to |
| `shud` | should, ought to |
| `maita` | might, may possibly |

**10.3.2** A clause may contain at most one modal.

**10.3.3** Modals are function words, not verbs. They cannot take an object, and
they cannot appear later in a serial verb chain.

**10.3.4** "Want", "try", "start" and "stop" are **not** modals. They are
ordinary verbs, used as the first verb of a serial chain
([§13.4](#13-serial-verbs)).

### 10.4 Order before the verb

**10.4.1** The words before the first verb must come in this fixed order. Each
may appear at most once.

**`no`** (negation) → **tense** (`bin` / `fina`) → **aspect** (`am`) →
**modal** → **verb**

**10.4.2** All of these apply to the whole verb chain
([§13.3](#13-serial-verbs)).

```
mi  bin  niam  fish.
I   PST  eat   fish
```
"I ate fish."

```
mi  fina  am    niam  fish.
I   FUT   PROG  eat   fish
```
"I will be eating fish."

```
mi  no   bin  am    niam  fish.
I   NEG  PST  PROG  eat   fish
```
"I wasn't eating fish."

```
mi  no   bin  kian  niam  fish.
I   NEG  PST  can   eat   fish
```
"I couldn't eat fish."

```
dei  maita  seliep.
he   might  sleep
```
"He might be asleep."

---

## 11. Negation

**11.1** The negation word is `no`. It comes before the verb, and before any
tense, aspect or modal word (see [§10.4](#104-order-before-the-verb)).

```
mi  no   niam  fish.
I   NEG  eat   fish
```
"I don't eat fish."

**11.2** In a serial verb chain, `no` comes before the first verb and negates the
whole chain (see [§13.3](#13-serial-verbs)).

**11.3 Negation with a modal.** Because `no` always comes first, it negates the
modal itself:

```
iu   no   mos   niam.          iu   no   kian  niam.
you  NEG  must  eat            you  NEG  can   eat
```
"You don't have to eat." / "You can't eat" or "You may not eat."

There is no separate way to say "must not". Use `no kian` ("may not").

**11.4** `no` is also the answer "no" ([§15.3](#153-answering-yesno-questions))
and the question marker ([§15.1](#151-yesno-questions)). Its position always
makes clear which use is meant.

---

## 12. The copula `bi` and existence

### 12.1 `bi`

**12.1.1** `bi` is the **copula**: the word for "is" when it means "is the same
as" or "is a kind of". Grammatically, `bi` is a verb. It fills the verb slot,
may take negation, tense, aspect and a modal, and may appear in a serial verb
chain. It is a function word.

```
mi  bi   pasin.
I   COP  person
```
"I am a person."

```
dei  bin  bi   mi  dag.
it   PST  COP  my  dog
```
"It was my dog."

### 12.2 Adjectives after `bi`

**12.2.1** `bi` is the only word that may take bare adjectives as its object.
This is how Astu says "X is (adjective)". It is the only place an adjective may
appear without a noun.

**12.2.2** `bi` may be followed by one or more adjectives. Repeating an adjective
intensifies it, just as in a noun phrase
([§8.4.3](#84-adjectives)).

```
dag  bi   big.
dog  COP  big
```
"The dog is big."

```
dag  bi   tiad   sik.
dog  COP  tired  sick
```
"The dog is tired and sick."

```
dag  bi   big  big.
dog  COP  big  big
```
"The dog is very big."

**12.2.3** Because adjectives also begin noun phrases, the words after `bi` are
a predicate adjective only if **no noun follows them**. If a noun follows, they
all belong to a noun phrase:

```
dag  bi   big  big.           dag  bi   big  big  kiat.
dog  COP  big  big            dog  COP  big  big  cat
```
"The dog is very big." / "The dog is a very big cat."

This is never ambiguous, because a noun cannot begin the next verb in a chain,
but a reader must look past the adjectives to tell which is meant.

### 12.3 Existence: `abi`

**12.3.1** The core verb `abi` means "exist". It is how Astu says "there is" or
"there are". `abi` never takes an object.

```
dag  abi.
dog  exists
```
"There is a dog."

```
fish  dem  abi     pon    ia    pelais.
fish  PL   exist   be-at  PROX  place
```
"There are fish here."

**12.3.2** "Have" is an ordinary dictionary verb, not a core verb.

---

## 13. Serial verbs

**13.1** A clause may contain a **chain of verbs** with no linking word between
them. This is called a **serial verb construction**. Each verb may have its own
object.

**subject – verb₁ (object₁) – verb₂ (object₂) – …**

```
mi  tek   naif   kot  bared.
I   take  knife  cut  bread
```
"I take a knife and cut the bread." That is: "I cut the bread with a knife."

**13.2** All verbs in a chain share the clause's single subject.

**13.3** Negation, tense, aspect and modal words come before the first verb
only, and apply to the whole chain.

```
mi  bin  tek   naif   kot  bared.
I   PST  take  knife  cut  bread
```
"I cut the bread with a knife." (past)

**13.4 Want, try, start, stop.** Verbs such as "want", "try", "start" and
"stop" are ordinary dictionary verbs. With no object of their own, they come
first in a chain, and the verbs after them say what is wanted, tried, started
or stopped. Because they are verbs, not modals, several may be combined, and a
modal may come before them: "I can start eating fish" is *I · can · start ·
eat · fish*.

**13.5** Serial verbs replace prepositions ([§9.3](#93-no-prepositions)) and
replace embedded clauses that share their subject with the main clause
([§9.4](#94-no-embedded-clauses)).

**13.6 Place and time.** The place or time of an action is given with `pon`
("be at"), usually at the end of the chain:

```
mi  bin  niam  fish  pon    ia    pelais.
I   PST  eat   fish  be-at  PROX  place
```
"I ate fish here."

```
dag  seliep  pon    dea   taim.
dog  sleeps  be-at  DIST  time
```
"The dog sleeps then."

**13.7** The parser always knows where each verb's object ends, because the
class of every word is known ([§6.3](#63-identifying-a-words-class)): a noun
phrase ends when the next word cannot continue it.

---

## 14. Comparison

**14.1 "More than".** Comparison uses the core verb `pas` ("pass, exceed") in a
serial verb chain. "A is bigger than B" is "A is big, passing B".

```
dag  bi   big  pas   kiat.
dog  COP  big  pass  cat
```
"The dog is bigger than the cat."

**14.2** Because `pas` works with any verb, it can also compare actions:

```
mi  niam  fish  pas   iu.
I   eat   fish  pass  you
```
"I eat more fish than you."

**14.3 "Most".** The superlative uses `pas` with the standalone quantifier `al`
("all"):

```
ia    dag  bi   big  pas   al.
PROX  dog  COP  big  pass  all
```
"This dog is the biggest."

**14.4 "As … as".** Equality uses the core verb `siem` ("equal"):

```
dag  bi   big  siem   kiat.
dog  COP  big  equal  cat
```
"The dog is as big as the cat."

---

## 15. Questions

### 15.1 Yes/no questions

**15.1.1** A yes/no question is formed by adding `no` to the **end** of an
ordinary statement.

```
iu   niam  fish  no?
you  eat   fish  Q
```
"Do you eat fish?"

**15.1.2** A question-marking `no` can never be mistaken for negation, because
negation always comes before a verb, and nothing follows the question marker.

**15.1.3** Negative questions are allowed:

```
iu   no   niam  fish  no?
you  NEG  eat   fish  Q
```
"Don't you eat fish?"

**15.1.4** In a sentence with several clauses ([§17](#17-sentences-with-several-clauses)),
a final `no` makes the **whole sentence** a question. To ask about only one
clause, make that clause its own sentence.

### 15.2 Question-word questions

**15.2.1** Questions asking "who", "what", "where" and similar are formed with a
question word `wa` ("which?") followed by a **general noun**. The general
noun says what kind of answer is wanted.

| General noun | Meaning | Question phrase | English |
|---|---|---|---|
| `pasin` | person | `wa pasin` | who |
| `tin` | thing | `wa tin` | what |
| `pelais` | place | `wa pelais` | which place |
| `taim` | time | `wa taim` | which time |
| `rizon` | reason | `wa rizon` | which reason |
| `wei` | way | `wa wei` | which way |
| `moch` | amount | `wa moch` | how much, how many |

**15.2.2** The general nouns are ordinary nouns listed in this specification.
They may also be used in statements: `dea pasin` means "that person".

**15.2.3** The question phrase goes in the same place as the answer would go.
The word order of the sentence does not change.

```
iu   niam  wa     tin?
you  eat   which  thing
```
"What do you eat?"

```
wa     pasin   niam  fish?
which  person  eats  fish
```
"Who eats fish?"

**15.2.4** Because there are no prepositions, "where", "when", "why" and "how"
use the matching core verb in a serial chain:

| English | Astu | Literally |
|---|---|---|
| where? | `… pon wa pelais?` | be at which place |
| when? | `… pon wa taim?` | be at which time |
| why? | `… fi wa rizon?` | for which reason |
| how? | `… tek wa wei?` | use which way |

```
iu   niam  fish  pon    wa     pelais?
you  eat   fish  be-at  which  place
```
"Where do you eat fish?"

```
iu   kot  bared  tek  wa     wei?
you  cut  bread  use  which  way
```
"How do you cut bread?"

**15.2.5** "How many" uses `moch` as the head, with the counted noun as a
describing noun before it:

```
iu   bin  niam  wa     fish  moch?
you  PST  eat   which  fish  amount
```
"How many fish did you eat?"

**15.2.6** A question-word question does not end in `no`.

**15.2.7** An answer to a question-word question must be a full clause
([§9.5](#95-every-sentence-is-a-clause)):

```
iu   niam  wa     tin?       mi  niam  fish.
you  eat   which  thing      I   eat   fish
```
"What do you eat?" "I eat fish."

### 15.3 Answering yes/no questions

**15.3.1** The answer "yes" is `ie`. The answer "no" is `no`. Each may stand
alone as a sentence.

```
iu   niam  fish  no?        ie.
you  eat   fish  Q          yes
```
"Do you eat fish?" "Yes."

### 15.4 Questions and commands

**15.4.1** A sentence that contains a command ([§16](#16-commands)) cannot be a
question. It may not end in the question marker `no`, and it may not contain
`wa`.

---

## 16. Commands

**16.1** A command is formed by leaving out the subject, as in English.

```
niam  fish.
eat   fish
```
"Eat the fish."

**16.2** A command forbidding something starts with `no`.

```
no   niam  fish!
NEG  eat   fish
```
"Don't eat the fish!"

**16.3** Tense and aspect markers must not be used in a command. A modal may be
used:

```
shud    seliep.
should  sleep
```
"You should sleep."

**16.4** A clause with no subject is always a command. The parser can always
tell, because a command begins with `no`, a modal or a verb, and a statement
always begins with a noun phrase.

---

## 17. Sentences with several clauses

**17.1** A sentence may contain several clauses. Exactly one **linking word**
must stand between each pair of clauses.

**17.2** A linking word comes **before** the clause it introduces.

**17.3** A linking word must never begin a sentence. The clause it introduces
always comes after another clause.

**17.4** The linking words:

| Linking word | The clause after it is… |
|---|---|
| `an` | an additional statement ("and") |
| `bot` | a contrasting statement ("but") |
| `ou` | an alternative ("or") |
| `so` | the result of the previous clause ("so") |
| `kaz` | the reason for the previous clause ("because") |
| `if` | the condition for the previous clause ("if") |
| `wen` | the time of the previous clause ("when") |

```
mi  seliep  if  iu   niam  fish.
I   sleep   if  you  eat   fish
```
"I sleep if you eat fish."

```
mi  bin  seliep  kaz      mi  bin  bi   tiad.
I   PST  sleep   because  I   PST  COP  tired
```
"I slept because I was tired."

**17.5** Clauses inside one sentence must always be separated by a linking word.
Without one, the boundary between them would be unclear. For example, in
`mi luk dag kiat niam fish`, `dag kiat` could be a describing noun followed by
a head noun ("dog cat").

**17.6 Commands come first.** A sentence may mix commands and other clauses,
but every command clause must come **before** every other clause.

```
no   niam  fish  if  iu   bi   sik.
NEG  eat   fish  if  you  COP  sick
```
"Don't eat fish if you're sick."

```
luk   kiat  an   mi  fina  niam  fish.
look  cat   and  I   FUT   eat   fish
```
"Look at the cat, and I'll eat fish."

**17.6.1** This means a subjectless clause can only follow another command. A
sentence such as `mi niam fish an luk kiat` is **ungrammatical**: it does not
mean "I eat fish and see the cat". Give each clause its own subject instead:
`mi niam fish an mi luk kiat.`

**17.7** Separate sentences need no linking word. Later sentences may refer
back with pronouns, a repeated noun, or a standalone `dea` ([§8.9](#89-noun-phrases-with-no-head-noun)).

---

## 18. Reported speech and thought

**18.1** Because there are no embedded clauses ([§9.4](#94-no-embedded-clauses)),
verbs of saying, thinking and knowing take a standalone demonstrative as their
object, and the content is given in a separate sentence:

- `ia` points **forward** to the sentence or sentences that follow;
- `dea` points **back** to what has just been said.

```
dei  bin  chat  ia.    "mi  bi   tiad."
he   PST  say   PROX    I   COP  tired
```
"He said: 'I am tired.'"

```
iu   bin  niam  fish.   mi  sabi  dea.
you  PST  eat   fish    I   know  DIST
```
"You ate fish. I know that."

**18.2** Direct and indirect speech are not distinguished. The reported
sentence keeps the speaker's own words.

**18.3** Quotation marks around the reported sentence are optional
([§5.2.4](#52-punctuation)).

---

## 19. Numbers and quantifiers

### 19.1 Digit words

**19.1.1** Astu counts in **base 10**. There is one word for each digit:

| Digit | Word | | Digit | Word |
|---|---|---|---|---|
| 0 | `ziro` | | 5 | `faiv` |
| 1 | `wan` | | 6 | `sikis` |
| 2 | `tu` | | 7 | `sefen` |
| 3 | `tiri` | | 8 | `eit` |
| 4 | `foa` | | 9 | `nain` |

**19.1.2** A number is a sequence of digit words, read exactly as it is written
in digits. There are no words for "ten", "hundred" or other powers.

```
tu  tiri           = 23
wan  ziro  ziro    = 100
```

**19.1.3** A number must not begin with `ziro`, except the number zero itself,
which is `ziro` on its own.

**19.1.4** Number words are function words. In a noun phrase they fill the
number slot, after any determiner and before the adjectives
([§8.2](#82-order-of-a-noun-phrase)).

```
tu   tiri   dag  dem
two  three  dog  PL
```
"23 dogs"

### 19.2 Writing numbers as digits

Numbers may be written with digits ([§5.2.5](#52-punctuation)): `23 dag dem`
is read `tu tiri dag dem`.

### 19.3 Quantifiers

**19.3.1** The quantifiers are function words that fill the number slot of a
noun phrase.

| Quantifier | Meaning | Takes `dem`? |
|---|---|---|
| `al` | all | yes |
| `som` | some | yes |
| `nof` | many | yes |
| `fiu` | few | yes |
| `eri` | every | no: singular noun |
| `notin` | none, no | no: singular noun |

```
nof   fish  dem        eri    dag
many  fish  PL         every  dog
```
"many fish" / "every dog"

**19.3.2** A noun phrase may contain a number **or** a quantifier, but not both.

**19.3.3** `notin` ("none") is a different word from `no` (negation).
`notin dag` means "no dog".

**19.3.4** A quantifier may stand alone as a complete noun phrase
([§8.9](#89-noun-phrases-with-no-head-noun)):

```
al   bin  niam  fish.
all  PST  eat   fish
```
"Everyone ate fish."

> ⚠ **Not yet specified:** ordinal numbers ("first", "second"); fractions and
> decimals; whether a noun counted with `ziro` (zero) takes `dem`.

---

## 20. Making new words

**20.1** Astu has **no compounding** (joining two roots into one word) and no
general system of derivation. New concepts are either new dictionary words, or
noun phrases built from a head and describing nouns
([§8.3](#83-describing-nouns)).

**20.2 Class-changing prefixes.** Astu has exactly three prefixes. Each one
turns a word of one class into a word of another class. Each prefix has two
forms: one used before a root that begins with a consonant, and one, ending in
a linking `z`, used before a root that begins with a vowel.

| Before a consonant | Before a vowel | Makes a… | Gloss |
|---|---|---|---|
| `di-` | `diz-` | noun | `N-` |
| `me-` | `mez-` | verb | `V-` |
| `lai-` | `laiz-` | adjective | `A-` |

```
di + niam  = diniam      me + big  = mebig      lai + dag  = laidag
di + abi   = dizabi      me + eg   = mezeg      lai + eg   = laizeg
```

**20.2.1** Because no root begins with `z` ([§3.2.2](#32-reserved-first-syllables)),
a `z` straight after a prefix is always the linking `z`, never part of the
root. `dizabi` can only be `diz` + `abi`.

**20.2.2** The linking `z` keeps the root's vowels apart from the prefix's, so a
prefix never creates a doubled vowel or three vowels in a row
([§2.2](#22-vowel-glides)).

**20.2.3** In this document, prefixes are named by the form used before a
consonant: "the prefix `di-`" includes `diz-`.

**20.3 Meanings.** The meaning of a prefixed word depends only on the prefix and
the class of the root:

| Prefix | From a verb | From an adjective | From a noun |
|---|---|---|---|
| `di-` | the act of doing it: `diniam` "eating" | the quality: `dibig` "bigness" | — |
| `me-` | — | make the object that way; with no object, become that way: `mebig` "enlarge, grow" | make the object into it; with no object, become it: `mebared` "make into bread" |
| `lai-` | tending to do it: `laiseliep` "sleepy" | — | like it, typical of it: `laidag` "dog-like" |

```
mi  mebig  dag.        dag  mebig.
I   V-big  dog         dog  V-big
```
"I make the dog big." / "The dog grows."

**20.4 Doers, tools and places.** There are no prefixes for "someone who", "a
thing for" or "a place for". These are made with a general noun and a
prefixed describing noun:

| Astu | Literally | Meaning |
|---|---|---|
| `diniam pasin` | eating person | eater |
| `dikot tin` | cutting thing | cutter |
| `diseliep pelais` | sleeping place | bedroom |

**20.5 Rules.**

- **20.5.1** A prefix may be added to any noun, verb or adjective, including the
  general nouns and core verbs (`ditek` "use", the noun). It must not be added
  to `bi`, to a pronoun or to any other function word.
- **20.5.2** A prefix must not be added to a word that is already of the class
  it makes. There is no `di-` on a noun.
- **20.5.3** A word may have at most one prefix. Prefixes never stack.
- **20.5.4** A prefixed word is an ordinary word of its new class.
- **20.5.5** The meaning of a prefixed word is always exactly the meaning given
  by 20.3. The dictionary never gives a prefixed word a special meaning. A
  concept that needs a different meaning gets its own root word.
- **20.5.6** No other word may begin with `di`, `me` or `lai`, and no root may
  begin with `z` ([§3.2](#32-reserved-first-syllables)), so a prefix and its
  root can always be told apart.

**20.6 Proper names.** Names have no special marker and no special rules. A name
is an ordinary noun: it obeys every shape rule ([§3](#3-word-shape)) and is
written in lowercase. This specification gives no rule for adapting names
from other languages.

---

## 21. Fixed phrases

**21.1** Greetings and similar expressions are ordinary sentences used as fixed
phrases. They follow every rule of the grammar.

| Astu | Literally | Meaning |
|---|---|---|
| `mi luk iu.` | I see you. | hello |
| `mi fina luk iu.` | I will see you. | goodbye |

**21.2** Astu has no special words for politeness ("please"), emphasis or topic.
Politeness is expressed through fixed phrases and through the choice of modal
(for example `shud` instead of a bare command).

---

## 22. Not yet specified

These small parts of the language are still open:

- **"Each other".** A reciprocal word ([§7.8](#7-pronouns)).
- **Ordinals, fractions and decimals** ([§19](#19-numbers-and-quantifiers)).
- **Zero and plurality.** Whether `ziro` takes `dem` ([§19](#19-numbers-and-quantifiers)).
- **Greetings.** Whether `mi luk iu.` (hello) and `mi fina luk iu.` (goodbye)
  are confirmed, and whether more fixed phrases are listed ([§21](#21-fixed-phrases)).

---

## Appendix A: Function word list

### A.1 Grammatical words

| Word | Meaning | Section |
|---|---|---|
| `mi` | I, me | [§7](#7-pronouns) |
| `iu` | you (one person) | [§7](#7-pronouns) |
| `dei` | he, she, it | [§7](#7-pronouns) |
| `midem` | we, us | [§7](#7-pronouns) |
| `iudem` | you (more than one person) | [§7](#7-pronouns) |
| `deidem` | they, them | [§7](#7-pronouns) |
| `sef` | reflexive: myself, yourself, himself… | [§7.7](#7-pronouns) |
| `dem` | plural marker | [§8.5](#85-plural) |
| `ia` | this (near); refers forward | [§8.6](#86-demonstratives-ia-and-dea) |
| `dea` | that (far); refers back | [§8.6](#86-demonstratives-ia-and-dea) |
| `wa` | which? (question word) | [§8.7](#87-the-question-word-wa) |
| `bin` | past tense | [§10](#10-tense-aspect-and-modality) |
| `fina` | future tense | [§10](#10-tense-aspect-and-modality) |
| `am` | progressive aspect | [§10](#10-tense-aspect-and-modality) |
| `kian` | can, may | [§10.3](#103-modals) |
| `mos` | must | [§10.3](#103-modals) |
| `shud` | should | [§10.3](#103-modals) |
| `maita` | might | [§10.3](#103-modals) |
| `no` | negation; yes/no question marker; the answer "no" | [§11](#11-negation), [§15](#15-questions) |
| `ie` | the answer "yes" | [§15.3](#153-answering-yesno-questions) |
| `bi` | copula ("is") | [§12](#12-the-copula-bi-and-existence) |
| `an` `bot` `ou` `so` `kaz` `if` `wen` | linking words: and, but, or, so, because, if, when | [§17](#17-sentences-with-several-clauses) |
| `al` `som` `nof` `fiu` `eri` `notin` | quantifiers: all, some, many, few, every, none | [§19.3](#193-quantifiers) |
| `ziro` `wan` `tu` `tiri` `foa` `faiv` `sikis` `sefen` `eit` `nain` | digits 0–9 | [§19.1](#191-digit-words) |
| `di-` `me-` `lai-` (`diz-` `mez-` `laiz-` before a vowel) | prefixes: make a noun, verb, adjective | [§20](#20-making-new-words) |

### A.2 General nouns

| Word | Meaning |
|---|---|
| `pasin` | person |
| `tin` | thing |
| `pelais` | place |
| `taim` | time |
| `rizon` | reason |
| `wei` | way |
| `moch` | amount |

### A.3 Core verbs

| Word | Meaning |
|---|---|
| `tek` | take, use |
| `gib` | give |
| `fi` | belong to, be for |
| `guan` | go to |
| `kum` | come from |
| `pon` | be at |
| `wid` | be with |
| `pas` | pass, exceed |
| `siem` | equal |
| `abi` | exist |

---

## Appendix B: Sample vocabulary (non-normative)

These words are used in the examples in this document. They are **not** part of
the specification: the real vocabulary belongs in the Astu dictionary. Each
word obeys the shape rules ([§3](#3-word-shape)).

| Word | Class | Meaning |
|---|---|---|
| `bared` | noun | bread |
| `bad` | noun | bird |
| `buk` | noun | book |
| `dag` | noun | dog |
| `naif` | noun | knife |
| `kiat` | noun | cat |
| `eg` | noun | egg |
| `fish` | noun | fish |
| `kot` | verb | cut |
| `kuk` | verb | cook |
| `seliep` | verb | sleep |
| `sabi` | verb | know |
| `luk` | verb | see, look at |
| `niam` | verb | eat |
| `chat` | verb | say, talk |
| `big` | adjective | big |
| `likil` | adjective | small |
| `sik` | adjective | sick |
| `tiad` | adjective | tired |

---

## Appendix C: Grammar summary

This summary gathers the sentence rules into one place, written in a notation
that is common in programming. `A?` means A is optional, `A*` means zero or
more A, `A+` means one or more A, `A | B` means A or B, and quoted words are
literal Astu words.

```
sentence      = ( statements | commands | answer ) end
end           = "." | "?" | "!" | "?!"

answer        = "ie" | "no"
statements    = statement ( linker statement )* "no"?
commands      = command ( linker command )* ( linker statement )*
linker        = "an" | "bot" | "ou" | "so" | "kaz" | "if" | "wen"

statement     = noun-phrase "no"? tense? aspect? modal? verb-chain
command       = "no"? modal? verb-chain

tense         = "bin" | "fina"
aspect        = "am"
modal         = "kian" | "mos" | "shud" | "maita"

verb-chain    = verb-unit+
verb-unit     = "bi" ( noun-phrase | adjective+ )?
              | "abi"
              | verb noun-phrase?

noun-phrase   = base ( link nominal )*
base          = standalone | ( determiner | pronoun )? nominal
link          = "dei" | "deidem"
standalone    = "ia" | "dea" | quantifier
determiner    = demonstrative | "wa"
nominal       = count? adjective* describer* head "dem"?

head          = noun | pronoun
describer     = noun
count         = number | quantifier
number        = digit+
demonstrative = "ia" | "dea"

pronoun       = "mi" | "iu" | "dei" | "midem" | "iudem" | "deidem" | "sef"
quantifier    = "al" | "som" | "nof" | "fiu" | "eri" | "notin"
digit         = "ziro" | "wan" | "tu" | "tiri" | "foa"
              | "faiv" | "sikis" | "sefen" | "eit" | "nain"
```

**Notes on the grammar:**

- `noun`, `verb` and `adjective` are open-class words, identified from the
  dictionary ([§6.3](#63-identifying-a-words-class)). They include the general
  nouns, the core verbs (except `abi`, listed separately because it never takes
  an object) and words built with prefixes.
- Repeating an adjective ([§8.4.3](#84-adjectives)) is covered by `adjective*`
  and `adjective+`.
- A sentence-final `"no"` is the question marker ([§15.1](#151-yesno-questions)).
  A `"no"` at the start of a command, or before the tense, aspect, modal or verb
  of a statement, is negation.
- In `nominal`, the head is always the last noun in the run; every one before
  it is a describer ([§8.3.3](#83-describing-nouns)). A pronoun is never a
  describer, and a pronoun head never has describers.
- A `pronoun` before a `nominal` in `base` is a possessor
  ([§8.8.1](#88-possession)). Each `link` is a linking pronoun, and everything
  before it is the possessor of the `nominal` after it.
- Possession nests to the left: in `A dei B dei C`, `A dei B` is the possessor
  of `C` ([§8.8.7](#88-possession)). A determiner belongs to the first
  `nominal` ([§8.8.6](#88-possession)).
- After `"bi"`, adjectives are a predicate (`adjective+`) only when no noun or
  pronoun follows them; otherwise they begin a noun phrase
  ([§12.2.3](#122-adjectives-after-bi)).
- Constraints not shown by the rules above:
  - a pronoun is never followed by `"dem"`, and `"eri"` and `"notin"` are never
    followed by `"dem"` ([§8.5](#85-plural));
  - the `nominal` after a possessor `pronoun` or a `link` has a noun as its
    head ([§8.8](#88-possession));
  - the phrase before a `link` does not have a pronoun as its head and does not
    end in `"dem"`; the `link` is `"dei"` when that phrase is singular and
    `"deidem"` when it is plural ([§8.8.4](#88-possession)–[§8.8.9](#88-possession));
  - a number must not begin with `"ziro"` unless it is `"ziro"` alone
    ([§19.1.3](#191-digit-words));
  - a sentence containing a command must not contain `"wa"`
    ([§15.4](#154-questions-and-commands));
  - a sentence ends in `"?"` or `"?!"` exactly when it is a question
    ([§5.2](#52-punctuation)).
