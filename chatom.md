# Chatom

**Chatom** is a constructed language designed to be completely regular and
unambiguous. Its two founding principles are:

1. **Unambiguous structure.** Any valid Chatom sentence can be broken down into
   exactly one grammatical structure. A computer can parse it without guessing,
   and a learner never has to wonder which word goes with which.
2. **Phonetic spelling.** Each sound is written exactly one way, and each
   spelling is pronounced exactly one way. If you can read a word, you can say
   it; if you can hear a word, you can spell it. The only exceptions are
   foreign names, which are marked by an uppercase letter and may keep the
   spelling and pronunciation of their source language (§20.6), and code
   spans, text between backticks that is not Chatom at all (§5.3).

This document is the complete specification of the grammar and of every
function word. It is meant to be precise enough to build software from, while
remaining readable for someone with only a passing interest in linguistics.
Technical terms are explained when they first appear.

> **Status: draft.** A few small parts of the language are not yet decided.
> They are marked **⚠ Not yet specified** and collected in §22.

---

## 1. Conventions used in this document

**1.1 Normative language.** "Must" and "must not" state absolute rules of the
language. "May" states something that is allowed but optional.

**1.2 Examples.** Examples are given in three lines: the Chatom sentence, a
word-by-word gloss, and an English translation in quotes. In a translation,
words in parentheses are not in the Chatom. The translator inferred them from
context, as with an unstated unit (§8.12.2).

```
mi  niam  fish  dem.
I   eat   fish  PL
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
| `MEAS` | measure link, "an amount of" (`a`) |
| `PROX` | near demonstrative, "this" (`ia`) |
| `DIST` | far demonstrative, "that" (`dea`) |
| `Q` | yes/no question marker (sentence-final `no`) |
| `N-` `V-` `A-` | noun-, verb- and adjective-making prefixes (`di-`, `me-`, `lai-`) |

All other words are glossed with their English meaning. A pronoun used as a
possessor (§8.8) is glossed with the English possessive: `mi` as "my", `dei` as
"their" or "its", `sef` as "own". A following `dem` is still glossed `PL`:
`mi dem buk` is "my PL book". The linking pronoun `dei` (§8.8.4) is glossed
"its" after a singular possessor that is a thing or an animal, and "their"
after any other possessor.

**1.3.1 No added gender.** Chatom has no gender (§7.2), so glosses and
translations must not add one that the Chatom does not state. `dei` is glossed
and translated "it" for a thing or an animal, and singular "they" for a person
or for anything whose kind is unknown, with "themself" as its reflexive. "He"
or "she" may be used only when a word in the Chatom, such as a word meaning
"mother", gives the gender. A name never gives the gender.

**1.4 Sample vocabulary.** Most nouns, verbs and adjectives are not part of
this specification (§6). The examples borrow words from the non-normative
sample vocabulary in Appendix B.

---

## 2. Sounds

Chatom has **5 vowels** and **18 consonants**: 23 sounds in total. It has no
tone, and the length of a sound never changes the meaning of a word.

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

**2.1.1** Chatom has no long vowels. A doubled vowel such as `aa` must not occur.

### 2.2 Vowel glides

**2.2.1** Two *different* vowels side by side inside a word are pronounced as a
single syllable, in one smooth movement from the first to the second. Such a
pair is called a **glide** (or diphthong).

```
dei    = one syllable: d + ei
iu     = one syllable: iu
seliep = two syllables: se · liep
```

**2.2.2** Every ordered pair of two different vowels is a valid glide, giving
20 glides: `ae ai ao au ea ei eo eu ia ie io iu oa oe oi ou ua ue ui uo`.

**2.2.3** No more than two vowels may stand side by side within a word. A
sequence such as `aia` must not occur. This keeps syllable boundaries
unambiguous.

**2.2.4 Vowels across word boundaries.** Glides only happen *inside* a word.
When one word ends in a vowel and the next begins with one, the two vowels are
pronounced separately: `mi abi` is *mi · a · bi*, never *mia · bi*.

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
| `nh` | /ŋ/ | si**ng** |
| `l` | /l/ | **l**eg |
| `r` | /ɹ/ | **r**ed, as said in Australian English |
| `w` | /w/ | **w**et |

**2.3.1 Pronunciation details.**

- `r` is the English `r` of Australian English: the tongue approaches the roof
  of the mouth without touching it. It is never tapped or trilled. It is
  always followed by a vowel (§3.1), so it is always pronounced.
- `g` is always "hard", as in **g**o, never as in **g**em.
- `s` is always /s/, never voiced to /z/, even between vowels: `pasin` is
  *pa-sin*, never *pa-zin*.
- `nh` is always /ŋ/, as in si**ng**er, never /ŋg/ as in fi**ng**er: `sinha`
  is *si-ŋa*, never *sin-ga*. At the start of a word, say it with no /n/ or
  /g/ before or after it: `nhabi` is the "ng" of "singer" followed by *abi*.
- `n` is always /n/, even when the next word begins with `k` or `g`. In
  `pasin kum`, the `n` is never said as /ŋ/.

**2.3.2** Chatom has no sound /h/, no "y" sound /j/, and neither of the sounds
/ʒ/ (as in mea**s**ure) or /dʒ/ (as in **j**am).

---

## 3. Word shape

### 3.1 Syllables

**3.1.1** The vowel or glide at the heart of a syllable is called its
**nucleus**.

**3.1.2** A word may begin with a vowel or with a consonant. After the first
nucleus, every syllable is exactly **one consonant followed by one nucleus**.
Two consonants never stand side by side within a word.

**3.1.3** The **last** syllable of a word may also end in one consonant, which
may be any consonant except `w` and `r`. A final `w` would sound like the glide
`au` or `ou`, and a final `r` is silent in Australian English, so `kar` would
sound like `ka`.

```
pa · sin      valid: final consonant n
fish          valid: one syllable, final consonant sh
a · bi        valid: begins with a vowel
kiat          valid: glide ia, final consonant t
si · nha      valid: nh inside the word
sinh          valid: final consonant nh
nha · bi      valid: begins with nh
pan · tu      invalid: two consonants inside the word (n t)
daw           invalid: ends in w
kar           invalid: ends in r
```

**3.1.4** So doubled consonants such as `tt` or `nn` cannot occur.

**3.1.5** A word may be any number of syllables long, including one.

### 3.2 Reserved beginnings

**3.2.1** The letters `di`, `me` and `lai` at the start of a word are reserved
for the word-making prefixes (§20). No other word may begin with them, not a
root and not a function word, even when they are only part of the first
syllable: `dian`, `mei`, `dish` and `laik` are not valid roots. A word that
begins with `di`, `me` or `lai` is therefore always a prefix followed by a
root.

**3.2.2** No noun, verb or adjective may begin with `z`. Function words, such
as `ziro`, may. This lets each prefix take a linking `z` before a root that
begins with a vowel (§20.2).

### 3.3 Formal definition

In each pattern, `?` means "optional" and `( )*` means "zero or more times".

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

So splitting a word into syllables is always unambiguous: a new syllable begins
at every consonant, except a consonant at the very end of the word, which
belongs to the last syllable.

### 3.4 Names

**3.4.1** Foreign names are exempt from §2–§4 (§20.6.5).

**3.4.2** Native names, such as `chatom`, obey every rule (§20.6.2).

**3.4.3** The contents of a code span are also exempt (§5.3.6).

---

## 4. Stress

**4.1** In nouns, verbs and adjectives, stress always falls on the **first
syllable**. In a prefixed word (§20), that is the prefix.

**4.2** Function words are **unstressed** in normal speech. This includes the
pronouns (§7) and `bi` (§12.1), even though they stand where a noun or a verb
would.

**4.3** Stress is never written, and it never changes the meaning of a word.

```
PA·sin   SE·liep   LI·kil   DI·niam
```

---

## 5. Writing

### 5.1 The alphabet

Chatom is written in the basic Latin alphabet (plain ASCII, with no accents).
It uses 23 letters or letter pairs, one for each sound:

```
a  b  ch  d  e  f  g  i  k  l  m  n  nh  o  p  r  s  sh  t  u  v  w  z
```

**5.1.1** The letters `c`, `h`, `j`, `q`, `x` and `y` are never used on their
own.

**5.1.2** `sh`, `ch` and `nh` are each a single sound written with two
letters. Because `h` never appears on its own, they can never be misread: `s`
followed by `h` is always /ʃ/, `n` followed by `h` is always /ŋ/, and `c` only
ever appears as part of `ch`.

**5.1.3** Words are separated by spaces.

**5.1.4** Everything except foreign names and code spans (§5.3) is written in
**lowercase**, including the first word of a sentence and native names such as
`chatom`. Outside a code span, a word with an uppercase letter is always a
foreign name (§20.6.4).

**5.1.5** Foreign names (§20.6.6) and code spans (§5.3.6) are exempt from the
alphabet above and from 5.1.1 and 5.1.2.

### 5.2 Punctuation

**5.2.1** Every sentence ends with exactly one of these marks. A closing
quotation mark (§5.2.4) may follow it.

| Mark | Used for |
|---|---|
| `?` | every question (§15) |
| `?!` | a shouted or exclaimed question |
| `!` | any other shouted or exclaimed sentence |
| `.` | every other sentence, including ordinary commands |

**5.2.2** Punctuation never changes the grammar. A question is a question
because of its words (a final `no` or the question word `wa`), not because of
its `?`. The `!` shows only tone of voice.

**5.2.3** Chatom uses **no commas**, not even inside a foreign name. Clause
boundaries are always marked by linking words (§17). A comma may appear only
inside a code span, whose contents are not Chatom (§5.3).

**5.2.4** Quoted sentences may be put in quotation marks (`"…"`) to make
writing easier to read (§18). Quotation marks are optional. A quotation opens
directly before the first word of a sentence and closes directly after a
sentence's final mark, so it encloses one or more whole sentences. Quotation
marks never appear inside a sentence, and they never change the grammar.

**5.2.5 Digits.** Numbers may be written with the digits `0`–`9` instead of
number words. Each digit stands for its digit word (§19): `23` is read
`tu tiri`.

### 5.3 Code spans

Chatom text is often written in Markdown, which marks computer code and other
literal text by putting it between backticks (`` ` ``). Code spans exist only
so that such text stays valid Chatom.

**5.3.1** A **code span** is text between two single backticks, such as
`` `README.md` ``. Nothing inside a code span is Chatom. Its contents are never
read as words, digits, punctuation or the end of a sentence, and they are kept
exactly as written, including any spaces at the start or end.

**5.3.2** A code span may contain any characters, including spaces and line
breaks, except a backtick. It must contain at least one character. So two
backticks in a row never occur, and a backtick with no matching closing
backtick makes a sentence invalid.

**5.3.3** A code span stands as a word of its own, separated from its
neighbours by spaces. The sentence's final mark may follow it directly.

**5.3.4** A code span is a noun, and apart from 5.3.5 it follows the same
grammar as a foreign name (§20.6.9–§20.6.11). In glosses it is glossed as
itself, backticks included.

**5.3.5** Unlike foreign names (§20.6.7), code spans never join together. Two
code spans side by side, or a code span beside a foreign name, are a
describing noun followed by a head (§8.3).

**5.3.6** The contents of a code span are exempt from every rule in §2–§4,
§5.1 and §5.2. A code span is pronounced however its contents are normally
read.

**5.3.7** A code span may appear inside quotation marks (§5.2.4). A quotation
mark inside a code span is part of the code span, never the start or end of a
quotation.

```
dei   luk  `README.md`.
they  see  `README.md`
```
"They look at `README.md`."

---

## 6. Word classes

### 6.1 Open and closed classes

Chatom has three **open classes** of words and one **closed class**.

| Class | Open or closed | Where its words are listed |
|---|---|---|
| Noun | open | the Chatom dictionary |
| Verb | open | the Chatom dictionary |
| Adjective | open | the Chatom dictionary |
| Function word | closed | this specification (Appendix A.1) |

**6.1.1** An **open class** can gain new words at any time. Its words are
listed in a separate dictionary, not in this specification.

**6.1.2** The **closed class** of function words is fixed. Every function word
is defined in this specification. Function words include pronouns, grammatical
markers, modals, linking words, quantifiers, digit words and prefixes.

**6.1.3** This specification also defines a small, fixed set of **general
nouns** (§15.2) and **core verbs** (§9.3). They are ordinary nouns and verbs,
not function words, but the grammar depends on them, so they are defined here
(Appendix A.2 and A.3). They are also listed in the dictionary, which must
agree with this specification.

**6.1.4** Chatom has **no adverbs**. Meanings that other languages express with
adverbs are expressed with serial verbs (§13) or with function words.

### 6.2 No inflection

**6.2.1** Chatom is an **analytic** language. Words never change form to show
grammar: there are no endings, no agreement and no irregular forms. Grammar is
expressed entirely through word order and function words.

**6.2.2** The only way to build one word from another is with the three
class-changing prefixes (§20). A prefixed word is a new word in its own right,
not a different form of the old one.

**6.2.3** Chatom has no articles ("a", "the").

**6.2.4** Chatom has no interjections. Greetings and similar expressions are
fixed phrases built from ordinary sentences (§21).

### 6.3 Identifying a word's class

**6.3.1** Apart from code spans and foreign names, a word's form says nothing
about its class. Any word may begin with any sound.

**6.3.2** To find the class of a word:

1. If it is a code span (text between backticks), it is a noun (§5.3).
2. If it contains an uppercase letter, it is a foreign name, which is a noun
   (§20.6).
3. If it is a function word (Appendix A.1), it is that function word.
4. If it begins with `di`, `me` or `lai`, it is a prefixed word, and the prefix
   gives its class (§20).
5. Otherwise, look it up in the dictionary. Native names are found here.

**6.3.3** No noun, verb or adjective may be spelled the same as a function word.

---

## 7. Pronouns

**7.1** Chatom has three personal pronouns, distinguished by **person** (I /
you / they·it). Each is made plural with the separate word `dem` (§7.5).

| | Singular | Plural |
|---|---|---|
| 1st person | `mi` I, me | `mi dem` we, us |
| 2nd person | `iu` you | `iu dem` you (all) |
| 3rd person | `dei` they, them (one person), it | `dei dem` they, them |

**7.2** Pronouns have no gender. `dei` covers "he", "she", "it" and singular
"they". Glosses and translations of `dei` follow §1.3.1.

**7.3** There is only one "we". It does not distinguish "we, including you"
from "we, not including you".

**7.4** A pronoun has a single form. The same word is used as the subject, the
object and the possessor.

```
mi  luk  dei.        dei   luk  mi.
I   see  them        they  see  me
```
"I see them." / "They see me."

**7.5 Plural pronouns.** A pronoun is made plural in the same way as a noun,
with `dem` after it (§8.5.2). A plural pronoun is therefore two words.

**7.6** Anything else in the noun phrase comes before the pronoun, never
between the pronoun and `dem`: `tu mi dem` means "we two" (§8.10).

**7.7 Reflexive.** Chatom has a single reflexive pronoun, `sef`, used for every
person and number. It is used when the object is the same as the subject.

```
dei   luk  sef.
they  see  self
```
"They see themself."

Compare `dei luk dei.`, which means "they see them", where "them" is someone
else. With a plural subject, `sef` alone still means "themselves",
"ourselves" or "yourselves": `mi dem luk sef.` "We see ourselves."

**7.7.1** `sef` and `sef dem` always refer to the subject of their clause, so
they must not appear anywhere inside that subject: not as the subject itself,
not as its possessor, and not deeper inside it. `sef luk mi.`,
`sef dag luk mi.` and `sef dag dei eg bi big.` are ungrammatical.

**7.7.2** A command has no subject (§16). In a command, `sef` refers to the
person spoken to, and `sef dem` to the people spoken to: `luk sef.` "Look at
yourself."

**7.8 Pronouns act like nouns.** A pronoun is a function word, not a noun, but
in a noun phrase it acts like one: it may be the head or a possessor (§8.10).
Elsewhere in this specification, "noun" never includes pronouns. `mi`, `iu` and
`dei` may take `dem`. `sef` takes `dem` only to mean "each other" (§7.9). A
pronoun is never a describing noun, so a bare pronoun directly before the rest
of a noun phrase is always its possessor (§8.8.1).

**7.9 Reciprocal: "each other".** `sef` followed by `dem` means "each other".
It is used when the members of a plural subject act on one another.

```
dei   dem  luk  sef   dem.          dei   dem  luk  sef.
they  PL   see  self  PL            they  PL   see  self
```
"They see each other." / "They see themselves."

**7.9.1** `sef dem` may be used only when the subject of its clause is plural:
its head must be followed by `dem`, or it must be a standalone `al`, `som`,
`nof` or `fiu` (§8.9). It may also be used in a command (§16), which then
speaks to more than one person. `dag luk sef dem.` and
`eri dag luk sef dem.` are ungrammatical.

**7.9.2** `sef dem` may be a possessor, meaning "each other's" (§8.8.3).

---

## 8. Noun phrases

A **noun phrase** is a noun together with any words that describe it, such as
"those two small bird eggs".

### 8.1 The head comes last

**8.1.1** In a noun phrase, the main word (its **head**) comes **last**.
Everything that describes it comes before it, much as in English. Nothing may
follow the head of a noun phrase except the plural marker `dem`. For the head
of a possessive or amount phrase, see §8.8.4 and §8.12.6.

### 8.2 Order of a noun phrase

**8.2.1** A noun phrase must follow this fixed order. Every part except the
head is optional.

| # | Part | Example |
|---|---|---|
| 1 | Determiner: a demonstrative (`ia` / `dea`), the question word `wa`, a possessive pronoun, **or** a possessor + linking pronoun (§8.8) | `dea` that |
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

**8.2.2** A noun phrase has at most one determiner. A demonstrative, `wa` and a
possessor cannot be combined (§8.8.6).

**8.2.3** A possessive noun phrase (§8.8) or an amount phrase (§8.12) joins two
or more of these orders with a link word, `dei` or `a`.

### 8.3 Describing nouns

**8.3.1** A **describing noun** comes before the head and narrows down what
kind of thing it is, exactly like the first noun in English "bird egg".

```
bad   eg
bird  egg
```
"bird egg"

**8.3.2 Several describing nouns.** Each describing noun narrows down **the
word directly after it**, so the phrase is read as a nested chain from the
left.

```
dag  diseliep  pelais
dog  N-sleep   place
```
"dog-sleeping place", that is, a kennel. `dag` narrows down `diseliep`
("dog-sleeping"), and `dag diseliep` narrows down `pelais`.

**8.3.3** The head is always the **last** noun in the run. A noun phrase never
ends with a describing noun.

### 8.4 Adjectives

**8.4.1** Adjectives come before any describing nouns and the head noun. They
always describe the **head** noun, never a describing noun.

```
likil  bad   eg
small  bird  egg
```
"small bird egg": the egg is small, not the bird. Unlike English, this is
never ambiguous.

**8.4.2** Adjectives have no fixed order among themselves.

**8.4.3 Intensifying by repetition.** Repeating an adjective strengthens it.
Each extra repetition adds more intensity, with no limit.

```
big  dag                a big dog
big  big  dag           a very big dog
big  big  big  dag      an extremely big dog
```

### 8.5 Plural

**8.5.1** A noun with no plural marker is **singular**: `dag` means exactly one
dog. This holds for every noun, including substances (§8.12.2).

**8.5.2** The plural marker `dem` comes directly after the head, like the
English "-s". It must be used whenever there is more than one, even when a
number makes the amount obvious. This applies to nouns, to pronouns (§7.5,
§8.10.2) and to possessors (§8.8.5).

```
dag  dem          tu   dag  dem
dog  PL           two  dog  PL
```
"dogs" / "two dogs"

**8.5.3** The number one (`wan` on its own) and the quantifiers `eri`
("every") and `notin` ("none") take a singular head, which never takes `dem`
(§19.3): `wan dag` "one dog" and `eri dag` "every dog", never `wan dag dem` or
`eri dag dem`. A longer number that begins with `wan`, such as `wan ziro` (10),
is plural as usual.

### 8.6 Demonstratives: `ia` and `dea`

**8.6.1** `ia` means "this" (near), and `dea` means "that" (far). They fill the
determiner slot.

```
ia    dag           dea   dag  dem
PROX  dog           DIST  dog  PL
```
"this dog" / "those dogs"

### 8.7 The question word `wa`

**8.7.1** `wa` means "which?". It fills the determiner slot. A noun phrase
containing `wa` makes its sentence a question (§15.2).

```
wa     big  dag
which  big  dog
```
"which big dog?"

### 8.8 Possession

Chatom has no possessive marker. A possessor (the owner) is shown by its
position at the start of the noun phrase, in one of two ways.

**8.8.1 Pronoun possessors.** A bare pronoun at the start of a noun phrase is
the **possessor** of the head. It fills the determiner slot, so it comes
before any number, quantifier or adjective.

```
mi  buk          dei    tu   likil  dag  dem
my  book         their  two  small  dog  PL
```
"my book" / "their two small dogs"

**8.8.2** A possessive pronoun must be **bare**: it may be followed by `dem`,
but it must not have its own number, quantifier or adjectives.

```
mi  dem  buk          dei    dem  tu   dag  dem
my  PL   book         their  PL   two  dog  PL
```
"our book" / "their two dogs"

A possessor such as "we two" is expressed with a clause instead (§8.8.10):
`buk fi tu mi dem.` "The book belongs to us two."

**8.8.3 "Own": `sef`.** The reflexive `sef` may be a possessor. Like English
"own", it refers to the subject of the clause (§7.7.1).

```
dei   luk  sef  buk.          dei   luk  dei    buk.
they  see  own  book          they  see  their  book
```
"They see their own book." / "They see their book" (someone else's).

The reciprocal `sef dem` (§7.9) may also be a possessor, meaning "each
other's".

```
mi  dem  luk  sef  dem  buk   dem.
I   PL   see  own  PL   book  PL
```
"We look at each other's books."

**8.8.4 Noun possessors.** Any other possessor is a full noun phrase, followed
by the **linking pronoun** `dei`, followed by the thing owned, much like
English "the dog its egg". The linking pronoun is always `dei`, whatever the
number of the possessor. For its gloss, see §1.3.

```
dag  dei  eg                  dag  dem  dei    eg   dem
dog  its  egg                 dog  PL   their  egg  PL
```
"the dog's egg" / "the dogs' eggs"

The head of the whole noun phrase is the head of the thing owned: `eg` in both
examples. The possessor is a smaller noun phrase inside it. The linking pronoun
and the thing owned belong to the whole phrase, not to the possessor, so they
do not break §8.1.1.

**8.8.5 Plural possessors.** A plural possessor takes `dem` (§8.5.2) before
the linking pronoun.

```
tu   dag  dem  dei    eg   dem
two  dog  PL   their  egg  PL
```
"the two dogs' eggs"

**8.8.6** Everything before the linking pronoun, back to the start of the noun
phrase, belongs to the possessor. Everything after it describes the thing
owned. In particular, a demonstrative or `wa` at the start of the noun phrase
always belongs to the possessor.

```
dea   big  dag  dei  likil  eg          wa     pasin   dei    dag
DIST  big  dog  its  small  egg         which  person  their  dog
```
"that big dog's small egg" / "whose dog?"

The thing owned can never take its own determiner, so there is no direct
equivalent of "those eggs of mine". Say "my eggs", or use a separate sentence.

**8.8.7 Chains.** Because the possessor is itself a noun phrase, it may contain
its own possessor. Possession chains are read from left to right, as in
English.

```
mi  dag  dei  eg
my  dog  its  egg
```
"my dog's egg": `mi dag` ("my dog") is the possessor of `eg`.

**8.8.8** A standalone `ia`, `dea` or quantifier (§8.9) may be a noun
possessor:

```
dea   dei    eg                al   dei    dag  dem
DIST  their  egg               all  their  dog  PL
```
"the egg of the one just mentioned" / "everyone's dogs"

**8.8.9 Rules for linking pronouns.**

- A linking pronoun must always be followed by the thing owned. A noun phrase
  never ends with a linking pronoun.
- The possessor before a linking pronoun must not have a pronoun as its head.
  A pronoun possessor is always a bare pronoun, used as in 8.8.1.
- The head of the thing owned must be a noun, not a pronoun.

These rules keep possession unambiguous. Two noun phrases never stand side by
side, and a pronoun is never a describing noun (§7.8). So inside a noun
phrase, a bare pronoun at the start that is followed by more of the noun
phrase is always a possessor, and a pronoun directly after a possessor is
always a linking pronoun.

**8.8.10 Ownership as a statement.** To *say* that something belongs to
someone, use the core verb `fi` ("belong to", §9.3):

```
buk   fi           mi.
book  belongs-to   me
```
"The book is mine."

### 8.9 Noun phrases with no head noun

**8.9.1** Three kinds of word may stand alone as a complete noun phrase, with
no head noun. Nothing may follow them except a linking pronoun (§8.8.8):

- `dea`, which refers **back** to something already said, including a whole
  previous clause or sentence;
- `ia`, which refers **forward** to something about to be said;
- any quantifier (§19.3), meaning that amount of the people or things being
  talked about.

A standalone `ia` or `dea` never points at something in the world, as English
"this one" or "that one" can. To point, use the demonstrative with a general
noun: `dea tin` "that thing", `ia pasin` "this person".

```
iu   bin  niam  fish.   mi  sabi  dea.
you  PST  eat   fish    I   know  DIST
```
"You ate the fish. I know that."

### 8.10 Pronouns in noun phrases

**8.10.1** A pronoun head (§7.8) may take only a number or quantifier,
adjectives and `dem` (parts 2, 3 and 6 in §8.2). It must not take a
determiner, so no demonstrative, no `wa` and no possessor may come before it,
and it must not take describing nouns. `ia mi`, `wa dei dem` and `mi dei` are
ungrammatical. To ask "which of them?", ask about a general noun instead, such
as `wa pasin` ("which person?").

```
tu   mi  dem        al   dei   dem        tiad   mi
two  I   PL         all  they  PL         tired  I
```
"we two" / "all of them" / "tired me"

**8.10.2** A number or quantifier meaning more than one needs `dem` after a
pronoun, as after a noun (§8.5.2): "we two" is `tu mi dem`, and `tu mi` is
ungrammatical.

**8.10.3** A pronoun is never a describing noun (§7.8): `mi buk` means "my
book".

**8.10.4** `sef` and `sef dem` never take a number or quantifier. They may
take adjectives.

### 8.11 No joined noun phrases

**8.11.1** Chatom has no words for "and" or "or" between noun phrases. Instead:

- **Repeat the clause**, joined with a linking word (§17):

  ```
  dag  niam  fish  an   kiat  niam  fish.
  dog  eats  fish  and  cat   eats  fish
  ```
  "The dog and the cat each eat a fish."

- **Use the core verb `wid`** ("be with") in a serial verb chain (§13):

  ```
  dag  wid      kiat  niam  fish.
  dog  be-with  cat   eat   fish
  ```
  "The dog eats a fish with the cat."

- **"Or"** can only join whole clauses:

  ```
  iu   niam  fish  ou  iu   niam  bared.
  you  eat   fish  or  you  eat   bread
  ```
  "You eat a fish or you eat a (serving of) bread."

### 8.12 Amounts

**8.12.1 Every noun can be counted.** Chatom has no **mass nouns** (nouns like
English "water" or "sand" that cannot take a number). Every noun may take a
number, a quantifier and `dem`, including words for substances, ideas and
actions, such as `wata` ("water"), `airi` ("peace") and `diniam` ("eating").

**8.12.2 One portion.** A noun with no `dem` always means exactly one
(§8.5.1). For a substance or an idea, "one" means one portion, serving or
instance, and the reader works out how much from context.

```
mi  chug   wata.
I   drink  water
```
"I drink a water": one glass, cup or bottle of it, as context shows. Compare
English "I'll have a beer."

```
tu   wata   dem
two  water  PL
```
"two waters": two cups, two bottles or two of some other portion, as context
shows.

**8.12.3 Other amounts.** Any amount that is not exactly one portion takes
`dem`, just as a plural count noun does. This includes general statements
about a substance.

```
mi  chug   wata   dem.
I   drink  water  PL
```
"I drink water." (in general, or an amount larger than one portion)

```
notin  wata   abi.
none   water  exist
```
"There is no water." `notin` takes a singular noun (§8.5.3).

**8.12.4 Units.** To state the unit, put the unit first, then the **measure
link** `a`, then the kind of thing being measured. This is called an **amount
phrase**.

```
tu   kop  dem  a     wata
two  cup  PL   MEAS  water
```
"two cups of water"

A unit is an ordinary noun, such as `kop` ("cup"). Any noun may be used as a
unit. The unit is optional: `tu wata dem` leaves it to context, and
`tu kop dem a wata` states it.

**8.12.5 Meaning.** An amount phrase "X `a` Y" means only "an amount of Y,
measured in X". `a` must not be used for any other kind of English "of". "A
book about Chatom" is `chatom buk`, with a describing noun (§8.3). "A person
from Sydney" uses the core verb `kum` (§9.3). Without `a`, `wata kop` is an
ordinary describing noun before a head: a water cup, that is, a cup used for
water.

**8.12.6 Grammar.** The measure link `a` follows the same grammar as the
linking pronoun `dei` (§8.8.4–§8.8.9):

- Everything before `a`, back to the start of the noun phrase, is the unit.
  A determiner, possessor or count at the start belongs to the unit, and so do
  the adjectives before it. A plural unit's `dem` comes before `a`.
- Everything after `a` is the kind measured. The head of the whole noun phrase
  is the head of the kind (§8.1.1).
- `a` must always be followed by the kind. A noun phrase never ends with `a`.
- The unit must have a noun as its head. It must not be a pronoun or a
  standalone `ia`, `dea` or quantifier (§8.9), so `mi a wata`, `dea a wata`
  and `al a wata` are ungrammatical. "All the water" is `al wata dem`.
- The kind must have a noun as its head.

```
ia    big  kop  a     wata
PROX  big  cup  MEAS  water
```
"this big cup of water": `ia` and `big` belong to the cup.

**8.12.7 The kind.** The kind says *what* is measured, not how many. It must
not take a determiner, a possessor, a number or a quantifier. A bare kind means
the substance in general, and a kind with `dem` means separate items:
`kop a wata` "a cup of water", `kop a eg dem` "a cup of eggs". This is the only
place where a noun without `dem` does not mean exactly one.

**8.12.8 Chains.** Links nest to the left, as in possession chains (§8.8.7).
Each `dei` or `a` applies to everything before it.

```
mi  dag  dei  kop  a     wata
my  dog  its  cup  MEAS  water
```
"my dog's cup of water": `mi dag dei kop` ("my dog's cup") is the unit.

---

## 9. Clauses

A **clause** is a single statement of "who does what (to what)", like "the dog
eats a fish".

### 9.1 Word order

**9.1.1** A clause has the order **subject – verb – object** (SVO).

```
dag  niam  fish.
dog  eats  fish
```
"The dog eats the fish."

### 9.2 Transitivity

**9.2.1** Every verb has a fixed **transitivity**, which says whether it takes
an object. The dictionary records the transitivity of every verb it lists.
There are three kinds:

| Transitivity | Object |
|---|---|
| **transitive** | must have an object |
| **intransitive** | must not have an object |
| **ambitransitive** | may have an object or not |

**9.2.2** The core verbs have the transitivity given in §9.3. Every verb made
with the prefix `me-` is ambitransitive (§20.3); such verbs are not listed
(§20.5.7). `bi` has its own rule (§12.1).

`niam` ("eat") is ambitransitive, and `seliep` ("sleep") is intransitive:

```
mi  niam.            mi  niam  fish.            dag  seliep.
I   eat              I   eat   fish             dog  sleeps
```
"I eat." / "I eat a fish." / "The dog sleeps."

**9.2.3** Finding a verb's object never depends on its transitivity. A verb is
followed by an object only if the next word can begin a noun phrase (a noun, a
pronoun, an adjective, a number, a quantifier, `ia`, `dea` or `wa`). If the
next word is a verb, a linking word, the question marker or the end of the
sentence, the verb has no object. So the structure of a sentence is always
found the same way, whatever its verbs are.

**9.2.4** Transitivity only decides whether that structure is grammatical. A
sentence in which a transitive verb has no object, or an intransitive verb has
one, is ungrammatical.

### 9.3 No prepositions

**9.3.1** Chatom has **no prepositions** (words like "in", "with", "to",
"for"). Relationships such as instrument, recipient, location and direction are
expressed with **core verbs** in a serial verb chain (§13). The measure link
`a` (§8.12) is not a preposition: like the linking pronoun `dei`, it links
parts of a noun phrase.

**9.3.2** The core verbs are a small, fixed set of ordinary verbs defined in
this specification, each with the transitivity given here (§9.2).

| Word | Meaning | Role it expresses | Transitivity |
|---|---|---|---|
| `tek` | take, use | instrument ("with a knife") | transitive |
| `gib` | give | recipient ("to them"); with no object, the recipient is unstated | ambitransitive |
| `fi` | belong to, be for | owner ("is theirs") and beneficiary or purpose ("for them") | transitive |
| `guan` | go to | direction ("to the house"); with no object, "go" | ambitransitive |
| `kum` | come from | source ("from the house"); with no object, "come" | ambitransitive |
| `pon` | be at | location and time ("in the house", "at noon") | transitive |
| `wid` | be with | accompaniment ("with them") | transitive |
| `pas` | pass, exceed | comparison ("more than"), §14 | transitive |
| `siem` | equal | comparison ("as … as"), §14 | transitive |
| `abi` | exist | existence ("there is"), §12.3 | intransitive |

```
mi  tek   fish  gib   dei.
I   take  fish  give  them
```
"I give the fish to them."

**9.3.3** The object of `gib` is always the **recipient**, never the thing
given. The thing given is the object of an earlier verb in the chain, usually
`tek`. With no object, `gib` leaves the recipient unstated, to be understood
from context.

```
mi  tek   naif   gib.
I   take  knife  give
```
"I give the knife away." or "I hand the knife over."

```
mi  kuk   fish  fi   dei.
I   cook  fish  for  them
```
"I cook a fish for them."

### 9.4 No embedded clauses

**9.4.1** Chatom has **no embedded clauses**. A clause can never appear inside
another clause, and a clause can never take the place of a noun phrase. There
is no equivalent of English "that", "who" or "which" introducing a clause.

**9.4.2** Meanings that other languages express with embedded clauses are
expressed in one of two ways:

- **Serial verbs**, when the two actions share a subject: "I want to eat
  fish", or "I went to buy food" (§13).
- **Separate clauses**, for everything else. The second clause refers back
  with a pronoun, a demonstrative, or a repeated noun.

| English | Chatom approach |
|---|---|
| "I know *that you ate the fish*." | "You ate the fish. I know that." (§18) |
| "The dog *that ate the fish* is sick." | "A dog ate the fish. That dog is sick." |
| "I slept *because you ate*." | "I slept `kaz` you ate." (§17) |

```
dag  bin  niam  fish.   dea   dag  bi   sik.
dog  PST  eat   fish    DIST  dog  COP  sick
```
"A dog ate the fish. That dog is sick." That is: "The dog that ate the fish is
sick."

### 9.5 Every sentence is a clause

**9.5.1** Every sentence must contain at least one full clause. A noun phrase
on its own is not a sentence: not as an answer, not as an exclamation, and not
to call someone by name.

**9.5.2** The only exceptions are the answers `ie.` ("yes") and `no.` ("no"),
which may stand alone (§15.3).

**9.5.3** Chatom has no vocative (a way of calling someone by name, as in
"Sara, look!"). Who is being spoken to is understood from context.

---

## 10. Tense, aspect and modality

**10.1** Tense (when something happens), aspect (how it unfolds over time) and
modality (ability, necessity and possibility) are shown by function words
placed directly before the first verb of the clause. Leaving out a tense or
aspect marker has a fixed meaning of its own (§10.2). Modals are optional
(§10.3).

### 10.2 Tense and aspect

| Marker | Meaning | Gloss |
|---|---|---|
| *(no tense marker)* | present | |
| `bin` | past | `PST` |
| `fina` | future | `FUT` |
| *(no `am`)* | simple: the action as a whole, a habit, a general truth or a state | |
| `am` | progressive: an action in progress, "is …ing" | `PROG` |

**10.2.1 Tense.** A verb with no tense marker is always **present**. It never
means past or future, whatever the context: not because of an earlier sentence
or clause, and not because of a time phrase such as `pon dea taim`. Every
clause about the past must use `bin`, and every clause about the future must
use `fina`. This includes a clause after a linking word (§17), and a future
event that English would put in the present:

```
mi  fina  seliep  if  iu   fina  niam  fish.
I   FUT   sleep   if  you  FUT   eat   fish
```
"I will sleep if you eat the fish."

**10.2.2** Tense is counted from the moment of speaking or writing. A quoted
sentence (§18) keeps its speaker's own words, so its tense is counted from the
moment that speaker spoke.

**10.2.3 Aspect.** A verb without `am` is never progressive. It presents the
action as a whole, a habit, a general truth or a state. `am` must be used
whenever an action is in progress at the time being talked about.

```
dag  seliep.            dag  am    seliep.
dog  sleeps             dog  PROG  sleep
```
"The dog sleeps." / "The dog is sleeping."

**10.2.4** `am` may be used with every verb and with `bi`, including `abi` and
verbs that name a state, such as `sabi` ("know"). With a state, it means that
the state holds only for now, at the time being talked about.

```
dag  am    bi   sik.
dog  PROG  COP  sick
```
"The dog is sick at the moment."

**10.2.5** Commands never take a tense or aspect marker (§16.3), so 10.2.1 and
10.2.3 do not apply to them.

**10.2.6** One tense marker may combine with `am`:

| Combination | Meaning |
|---|---|
| `bin am` | past progressive: "was …ing" |
| `fina am` | future progressive: "will be …ing" |

### 10.3 Modals

**10.3.1** Chatom has four **modals**:

| Modal | Meaning |
|---|---|
| `kian` | can, may, is able to, is allowed to |
| `mos` | must, has to |
| `shud` | should, ought to |
| `maita` | might, may possibly |

**10.3.2** A clause may contain at most one modal.

**10.3.3** Modals are function words, not verbs. They cannot take an object,
and they cannot appear later in a serial verb chain.

**10.3.4** "Want", "try", "start" and "stop" are **not** modals, but ordinary
verbs (§13.4).

### 10.4 Order before the verb

**10.4.1** The words before the first verb must come in this fixed order. Each
may appear at most once.

**`no`** (negation) → **tense** (`bin` / `fina`) → **aspect** (`am`) →
**modal** → **verb**

**10.4.2** All of these apply to the whole verb chain (§13.3).

```
mi  fina  am    niam  fish.
I   FUT   PROG  eat   fish
```
"I will be eating the fish."

```
mi  no   bin  am    niam  fish.
I   NEG  PST  PROG  eat   fish
```
"I wasn't eating the fish."

```
mi  no   bin  kian  niam  fish.
I   NEG  PST  can   eat   fish
```
"I couldn't eat the fish."

---

## 11. Negation

**11.1** The negation word is `no`. It comes before the verb, and before any
tense, aspect or modal word (§10.4).

```
mi  no   niam  fish  dem.
I   NEG  eat   fish  PL
```
"I don't eat fish."

**11.2** In a serial verb chain, `no` comes before the first verb and negates
the whole chain (§13.3).

**11.3 Negation with a modal.** Because `no` always comes first, it negates the
modal itself:

```
iu   no   mos   niam.          iu   no   kian  niam.
you  NEG  must  eat            you  NEG  can   eat
```
"You don't have to eat." / "You can't eat" or "You may not eat."

There is no separate way to say "must not". Use `no kian` ("may not").

**11.4** `no` is also the answer "no" (§15.3) and the question marker
(§15.1). Its position always makes clear which use is meant.

---

## 12. The copula `bi` and existence

### 12.1 `bi`

**12.1.1** `bi` is the **copula**: the word for "is" when it means "is the same
as" or "is a kind of". `bi` is a function word, not a verb, but it acts like
one: it fills the verb slot, may take negation, tense, aspect and a modal, and
may appear in a serial verb chain. Wherever this specification speaks of the
verb of a clause or the verbs of a chain, `bi` is included. Rules about a
verb's transitivity (§9.2) and about prefixes (§20.5.1) do not apply to it.

**12.1.2** `bi` must always be followed by a noun phrase or by one or more
adjectives (§12.2). A bare `bi` is ungrammatical. To say that something
exists, use `abi` (§12.3).

```
mi  bi   pasin.
I   COP  person
```
"I am a person."

### 12.2 Adjectives after `bi`

**12.2.1** `bi` is the only word that may take bare adjectives as its object.
This is how Chatom says "X is (adjective)". It is the only place an adjective
may appear without a noun or a pronoun after it.

**12.2.2** `bi` may be followed by one or more adjectives. Repeating an
adjective intensifies it, as in a noun phrase (§8.4.3).

```
dag  bi   tiad   sik.
dog  COP  tired  sick
```
"The dog is tired and sick."

**12.2.3** Because adjectives also begin noun phrases, the words after `bi` are
a predicate adjective only if **no noun or pronoun follows them**. If a noun or
a pronoun follows, they all belong to a noun phrase:

```
dag  bi   big  big.           dag  bi   big  big  kiat.
dog  COP  big  big            dog  COP  big  big  cat
```
"The dog is very big." / "The dog is a very big cat."

This is never ambiguous, because neither a noun nor a pronoun can begin the
next verb in a chain, but a reader must look past the adjectives to tell which
is meant.

### 12.3 Existence: `abi`

**12.3.1** The core verb `abi` means "exist". It is how Chatom says "there is"
or "there are". `abi` is intransitive (§9.2), so it never takes an object.

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

**13.4 Want, try, start, stop.** Verbs such as "want", "try", "start" and
"stop" are ordinary dictionary verbs, and they must not be transitive (§9.2).
With no object of their own, they come first in a chain, and the verbs after
them say what is wanted, tried, started or stopped. Because they are verbs,
not modals, several may be combined, and a modal may come before them: "I can
start eating the fish" is *I · can · start · eat · fish*.

**13.5** Serial verbs replace prepositions (§9.3) and replace embedded clauses
that share their subject with the main clause (§9.4).

**13.6 Place and time.** The place or time of an action is given with `pon`
("be at"), usually at the end of the chain:

```
mi  bin  niam  fish  pon    ia    pelais.
I   PST  eat   fish  be-at  PROX  place
```
"I ate a fish here."

**13.7** The parser always knows where each verb's object ends, because the
class of every word is known (§6.3): a noun phrase ends when the next word
cannot continue it.

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
mi  niam  fish  dem  pas   iu.
I   eat   fish  PL   pass  you
```
"I eat more fish than you."

**14.3 "Most".** The superlative uses `pas` with the standalone quantifier `al`
("all", §8.9):

```
ia    dag  bi   big  pas   al.
PROX  dog  COP  big  pass  all
```
"This dog is the biggest." (literally "this dog is big, surpassing all")

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
iu   niam  fish  dem  no?
you  eat   fish  PL   Q
```
"Do you eat fish?"

**15.1.2** A question-marking `no` can never be mistaken for negation, because
negation always comes before a verb, and nothing follows the question marker.

**15.1.3** Negative questions are allowed:

```
iu   no   niam  fish  dem  no?
you  NEG  eat   fish  PL   Q
```
"Don't you eat fish?"

**15.1.4** In a sentence with several clauses (§17), a final `no` makes the
**whole sentence** a question. To ask about only one clause, make that clause
its own sentence.

### 15.2 Question-word questions

**15.2.1** Questions asking "who", "what", "where" and similar are formed with
the question word `wa` ("which?") followed by a **general noun**, which says
what kind of answer is wanted.

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
wa     pasin   niam  fish  dem?
which  person  eats  fish  PL
```
"Who eats fish?"

**15.2.4** Because there are no prepositions, "where", "when", "why" and "how"
use the matching core verb in a serial chain:

| English | Chatom | Literally |
|---|---|---|
| where? | `… pon wa pelais?` | be at which place |
| when? | `… pon wa taim?` | be at which time |
| why? | `… fi wa rizon?` | for which reason |
| how? | `… tek wa wei?` | use which way |

```
iu   kot  bared  tek  wa     wei?
you  cut  bread  use  which  way
```
"How do you cut a (loaf of) bread?"

**15.2.5** "How many" and "how much" use `wa moch` ("which amount") as the
unit of an amount phrase (§8.12):

```
iu   bin  niam  wa     moch    a     fish  dem?
you  PST  eat   which  amount  MEAS  fish  PL
```
"How many fish did you eat?"

```
iu   bin  chug   wa     moch    a     wata?
you  PST  drink  which  amount  MEAS  water
```
"How much water did you drink?"

**15.2.6** A question-word question does not end in `no`.

**15.2.7** An answer to a question-word question must be a full clause (§9.5):

```
iu   niam  wa     tin?       mi  niam  fish  dem.
you  eat   which  thing      I   eat   fish  PL
```
"What do you eat?" "I eat fish."

### 15.3 Answering yes/no questions

**15.3.1** The answer "yes" is `ie`. The answer "no" is `no`. Each may stand
alone as a sentence.

```
iu   niam  fish  dem  no?   ie.
you  eat   fish  PL   Q     yes
```
"Do you eat fish?" "Yes."

### 15.4 Questions and commands

**15.4.1** A sentence that contains a command (§16) cannot be a question. It
may not end in the question marker `no`, and it may not contain `wa`.

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
mi  bin  seliep  kaz      mi  bin  bi   tiad.
I   PST  sleep   because  I   PST  COP  tired
```
"I slept because I was tired."

**17.5** Clauses inside one sentence must always be separated by a linking
word. Without one, the boundary between them would be unclear. For example, in
`mi luk dag kiat niam fish`, `dag kiat` could be a describing noun followed by
a head noun ("dog cat").

**17.6 Commands come first.** A sentence may mix commands and other clauses,
but every command clause must come **before** every other clause.

```
no   niam  fish  dem  if  iu   bi   sik.
NEG  eat   fish  PL   if  you  COP  sick
```
"Don't eat fish if you're sick."

```
luk   kiat  an   mi  fina  niam  fish.
look  cat   and  I   FUT   eat   fish
```
"Look at the cat, and I'll eat the fish."

**17.6.1** So a subjectless clause can only follow another command. A sentence
such as `mi niam fish an luk kiat` is **ungrammatical**: it does not mean "I
eat a fish and see the cat". Give each clause its own subject instead:
`mi niam fish an mi luk kiat.`

**17.7** Separate sentences need no linking word. Later sentences may refer
back with pronouns, a repeated noun, or a standalone `dea` (§8.9).

---

## 18. Reported speech and thought

**18.1** Because there are no embedded clauses (§9.4), verbs of saying,
thinking and knowing take a standalone demonstrative as their object, and the
content is given in a separate sentence. `ia` points **forward** to the
sentence or sentences that follow, and `dea` points **back** to what has just
been said (example in §8.9).

```
dei   bin  chat  ia.    "mi  bi   tiad."
they  PST  say   PROX    I   COP  tired
```
"They said: 'I am tired.'"

**18.2** Direct and indirect speech are not distinguished. The reported
sentence keeps the speaker's own words.

**18.3** Quotation marks around the reported sentence are optional (§5.2.4).

---

## 19. Numbers and quantifiers

### 19.1 Digit words

**19.1.1** Chatom counts in **base 10**. There is one word for each digit:

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
number slot, after any determiner and before the adjectives (§8.2).

```
tu   tiri   dag  dem
two  three  dog  PL
```
"23 dogs"

### 19.2 Writing numbers as digits

Numbers may be written with digits (§5.2.5): `23 dag dem` is read
`tu tiri dag dem`.

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

**19.3.4** A quantifier may stand alone as a complete noun phrase (§8.9):

```
al   bin  niam  fish  dem.
all  PST  eat   fish  PL
```
"Everyone ate fish."

> ⚠ **Not yet specified:** ordinal numbers ("first", "second"), fractions,
> decimals, and whether a noun counted with `ziro` takes `dem`. See §22.

---

## 20. Making new words

**20.1** Chatom has **no compounding** (joining two roots into one word) and no
general system of derivation. New concepts are either new dictionary words, or
noun phrases built from a head and describing nouns (§8.3).

**20.2 Class-changing prefixes.** Chatom has exactly three prefixes. Each turns
a word of one class into a word of another. Each has two forms: one used before
a root that begins with a consonant, and one, ending in a linking `z`, used
before a root that begins with a vowel.

| Before a consonant | Before a vowel | Makes a… | Gloss |
|---|---|---|---|
| `di-` | `diz-` | noun | `N-` |
| `me-` | `mez-` | verb | `V-` |
| `lai-` | `laiz-` | adjective | `A-` |

```
di + niam  = diniam      me + big  = mebig      lai + dag  = laidag
di + abi   = dizabi      me + eg   = mezeg      lai + eg   = laizeg
```

**20.2.1** Because no root begins with `z` (§3.2.2), a `z` straight after a
prefix is always the linking `z`, never part of the root. `dizabi` can only be
`diz` + `abi`.

**20.2.2** The linking `z` keeps the root's vowels apart from the prefix's, so
a prefix never creates a doubled vowel or three vowels in a row (§2.2).

**20.2.3** In this document, prefixes are named by the form used before a
consonant: "the prefix `di-`" includes `diz-`.

**20.3 Meanings.** The meaning of a prefixed word depends only on the prefix
and the class of the root:

| Prefix | From a verb | From an adjective | From a noun |
|---|---|---|---|
| `di-` | the act of doing it: `diniam` "eating" | the quality: `dibig` "bigness" | — |
| `me-` | — | make the object that way; with no object, become that way: `mebig` "enlarge, grow" | make the object into it; with no object, become it: `mebared` "make into bread" |
| `lai-` | tending to do it: `laiseliep` "sleepy" | — | like it, typical of it: `laidag` "dog-like" |

Because a `me-` verb has a meaning both with and without an object, every `me-`
verb is ambitransitive (§9.2).

```
mi  mebig  dag.        dag  mebig.
I   V-big  dog         dog  V-big
```
"I make the dog big." / "The dog grows."

**20.4 Doers, tools and places.** There are no prefixes for "someone who", "a
thing for" or "a place for". These are made with a general noun and a prefixed
describing noun:

| Chatom | Literally | Meaning |
|---|---|---|
| `diniam pasin` | eating person | eater |
| `dikot tin` | cutting thing | cutter |
| `diseliep pelais` | sleeping place | bedroom |

**20.5 Rules.**

- **20.5.1** A prefix may be added to any noun, verb or adjective, including
  the general nouns and core verbs (`ditek` "use", the noun). It must not be
  added to `bi`, to a pronoun, to a foreign name or to any other function word.
- **20.5.2** A prefix must not be added to a word that is already of the class
  it makes. There is no `di-` on a noun.
- **20.5.3** A word may have at most one prefix. Prefixes never stack.
- **20.5.4** A prefixed word is an ordinary word of its new class.
- **20.5.5** The meaning of a prefixed word is always exactly the meaning given
  by 20.3. A prefixed word never has a special meaning of its own. A concept
  that needs a different meaning gets its own root word.
- **20.5.6** A prefix and its root can always be told apart (§3.2).
- **20.5.7** Prefixed words are never listed in the dictionary. Their class
  comes from the prefix, their meaning from 20.3, and, for a `me-` verb, its
  transitivity from §9.2.2. Only the root is looked up.

**20.6 Proper names.** A **name** refers to one particular person, place or
thing, such as "Sarah", "New York" or the Chatom language. Chatom has two kinds
of name: **native names** and **foreign names**.

**Native names**

- **20.6.1** A **native name** is a Chatom word, such as `chatom`, the name of
  this language. It is written in **lowercase**, like every other Chatom word.
- **20.6.2** A native name is an ordinary noun in every way. It obeys every
  rule for sounds, word shape, stress and writing (§2–§5), and it is listed in
  the dictionary.
- **20.6.3** Like any noun, a native name may be a head, a describing noun or a
  possessor, it may take `dem`, and it may take a prefix: `laichatom`
  "Chatom-like". Two native names next to each other are a describing noun
  followed by a head (§8.3), never a single name.

**Foreign names**

- **20.6.4** A **foreign name** is a name taken from another language. Any
  word that contains an uppercase letter, anywhere in it, is a foreign name
  (unless it is a code span, §5.3), and every foreign name must contain at
  least one. Every foreign name is a noun.
- **20.6.5** A foreign name may be written exactly as in its source language
  (`Sarah`), or it may be **adapted**: respelled to suit Chatom sounds (`Sara`).
  Either way, it keeps an uppercase letter, and it is exempt from the rules for
  sounds, word shape, stress and the alphabet (§2–§4, §5.1.5). A foreign name
  written as in its source language is pronounced as in that language.
  > ⚠ **Not yet specified:** how an adapted foreign name is pronounced. See §22.
- **20.6.6** A foreign name may contain any letter, digit or punctuation mark,
  except that it must not contain a quotation mark (`"`), a backtick
  (`` ` ``) or a comma (`,`), and it must not end in `.`, `?` or `!`. So a
  sentence's final mark is never part of a name, and quotation marks (§5.2.4)
  and code spans (§5.3) are never part of one.
- **20.6.7** Several foreign names directly next to each other form a single
  name: `New York` is one noun, not a describing noun followed by a head
  (§8.3). So a foreign name can never be a describing noun directly before
  another foreign name.
- **20.6.8** A lowercase word is never part of a foreign name. A foreign name
  with a lowercase part may join it to its neighbours with hyphens, making one
  word that contains an uppercase letter: `Leonardo-da-Vinci`.
- **20.6.9** In every other way a foreign name is an ordinary noun. It may be a
  head, a describing noun or a possessor, and it may take `dem`. A foreign name
  must not take a prefix.
- **20.6.10** Foreign names are never listed in the dictionary.
- **20.6.11** In glosses, a foreign name is glossed as itself. A native name is
  glossed with its English name, like any other word.

```
mi  chat  chatom.
I   speak Chatom
```
"I speak Chatom."

```
Sarah  bin  guan   New York.
Sarah  PST  go-to  New York
```
"Sarah went to New York."

```
Sarah  dei    dag  bi   big.
Sarah  their  dog  COP  big
```
"Sarah's dog is big."

---

## 21. Fixed phrases

**21.1** Greetings and similar expressions are ordinary sentences used as fixed
phrases. They follow every rule of the grammar.

| Chatom | Literally | Meaning |
|---|---|---|
| `mi luk iu.` | I see you. | hello |
| `mi fina luk iu.` | I will see you. | goodbye |
| `guan ia pelais tek airi.` | Go to this place, take peace. | welcome |

> ⚠ **Not yet specified:** whether more fixed phrases are listed. See §22.

**21.2** Chatom has no special words for politeness ("please"), emphasis or
topic. Politeness is expressed through fixed phrases and through the choice of
modal (for example `shud` instead of a bare command).

---

## 22. Not yet specified

These small parts of the language are still open:

- **Ordinals, fractions and decimals** (§19).
- **Zero and plurality.** Whether `ziro` takes `dem` (§19).
- **More fixed phrases.** Whether more fixed phrases are listed (§21).
- **Adapted foreign names.** How an adapted foreign name is pronounced
  (§20.6).

---

## Appendix A: Words defined in this specification

A.1 lists every function word. A.2 and A.3 list the general nouns and core
verbs, which are ordinary nouns and verbs (§6.1.3).

### A.1 Function words

| Word | Meaning | Section |
|---|---|---|
| `mi` | I, me | §7 |
| `iu` | you (one person) | §7 |
| `dei` | they (one person), it; linking pronoun in possession | §7, §8.8.4 |
| `sef` | reflexive: myself, yourself, themself, itself…; with `dem`, each other | §7.7, §7.9 |
| `dem` | plural marker | §8.5 |
| `a` | measure link: an amount of | §8.12 |
| `ia` | this (near); refers forward | §8.6 |
| `dea` | that (far); refers back | §8.6 |
| `wa` | which? (question word) | §8.7 |
| `bin` | past tense | §10 |
| `fina` | future tense | §10 |
| `am` | progressive aspect | §10 |
| `kian` | can, may | §10.3 |
| `mos` | must | §10.3 |
| `shud` | should | §10.3 |
| `maita` | might | §10.3 |
| `no` | negation; yes/no question marker; the answer "no" | §11, §15 |
| `ie` | the answer "yes" | §15.3 |
| `bi` | copula ("is") | §12 |
| `an` `bot` `ou` `so` `kaz` `if` `wen` | linking words: and, but, or, so, because, if, when | §17 |
| `al` `som` `nof` `fiu` `eri` `notin` | quantifiers: all, some, many, few, every, none | §19.3 |
| `ziro` `wan` `tu` `tiri` `foa` `faiv` `sikis` `sefen` `eit` `nain` | digits 0–9 | §19.1 |
| `di-` `me-` `lai-` (`diz-` `mez-` `laiz-` before a vowel) | prefixes: make a noun, verb, adjective | §20 |

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

| Word | Meaning | Transitivity |
|---|---|---|
| `tek` | take, use | transitive |
| `gib` | give | ambitransitive |
| `fi` | belong to, be for | transitive |
| `guan` | go to | ambitransitive |
| `kum` | come from | ambitransitive |
| `pon` | be at | transitive |
| `wid` | be with | transitive |
| `pas` | pass, exceed | transitive |
| `siem` | equal | transitive |
| `abi` | exist | intransitive |

---

## Appendix B: Sample vocabulary (non-normative)

These words are used in the examples in this document. They are **not** part of
the specification: the real vocabulary belongs in the Chatom dictionary. Each
word obeys the shape rules (§3). Each verb's transitivity (§9.2) is chosen to
fit the examples.

| Word | Class | Meaning | Transitivity |
|---|---|---|---|
| `airi` | noun | peace | — |
| `bared` | noun | bread | — |
| `bad` | noun | bird | — |
| `buk` | noun | book | — |
| `dag` | noun | dog | — |
| `naif` | noun | knife | — |
| `kiat` | noun | cat | — |
| `kop` | noun | cup | — |
| `wata` | noun | water | — |
| `eg` | noun | egg | — |
| `fish` | noun | fish | — |
| `kot` | verb | cut | transitive |
| `kuk` | verb | cook | ambitransitive |
| `seliep` | verb | sleep | intransitive |
| `sabi` | verb | know | ambitransitive |
| `luk` | verb | see, look at | transitive |
| `niam` | verb | eat | ambitransitive |
| `chug` | verb | drink | ambitransitive |
| `chat` | verb | say, talk | ambitransitive |
| `chatom` | noun | Chatom (the language) | — |
| `big` | adjective | big | — |
| `likil` | adjective | small | — |
| `sik` | adjective | sick | — |
| `tiad` | adjective | tired | — |

---

## Appendix C: Grammar summary

This summary gathers the sentence rules into one place, in a notation common in
programming. `A?` means A is optional, `A*` means zero or more A, `A+` means
one or more A, `A | B` means A or B, and quoted words are literal Chatom words.

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
verb-unit     = "bi" ( noun-phrase | adjective+ )
              | transitive-verb noun-phrase
              | intransitive-verb
              | ambitransitive-verb noun-phrase?

noun-phrase   = base ( link nominal )*
base          = standalone | ( determiner | possessor )? nominal
possessor     = pronoun "dem"?
link          = "dei" | "a"
standalone    = "ia" | "dea" | quantifier
determiner    = demonstrative | "wa"
nominal       = count? adjective* describer* head "dem"?

head          = noun | pronoun
describer     = noun
count         = number | quantifier
number        = digit+
demonstrative = "ia" | "dea"

pronoun       = "mi" | "iu" | "dei" | "sef"
quantifier    = "al" | "som" | "nof" | "fiu" | "eri" | "notin"
digit         = "ziro" | "wan" | "tu" | "tiri" | "foa"
              | "faiv" | "sikis" | "sefen" | "eit" | "nain"
```

**Notes on the grammar:**

- `noun`, `adjective` and the three kinds of verb are open-class words,
  identified from the dictionary (§6.3), including the general nouns and core
  verbs. Prefixed words are not listed: the prefix gives their class
  (§20.5.7). The dictionary records each listed verb's transitivity (§9.2),
  and every `me-` verb is ambitransitive.
- A `noun` may also be a foreign name: a run of one or more adjacent words
  that each contain an uppercase letter, treated as a single word (§20.6).
- A `noun` may also be a code span, treated as a single word whose contents
  are not Chatom (§5.3). Adjacent code spans are separate nouns.
- A `number` may also be written with the digits `0`–`9` (§5.2.5): `23` is
  `"tu" "tiri"`.
- Quotation marks enclose whole sentences and are ignored by these rules
  (§5.2.4).
- Repeating an adjective (§8.4.3) is covered by `adjective*` and `adjective+`.
- A sentence-final `"no"` is the question marker (§15.1). A `"no"` at the
  start of a command, or before the tense, aspect, modal or verb of a
  statement, is negation.
- In `nominal`, the head is always the last noun in the run; every one before
  it is a describer (§8.3.3). A pronoun is never a describer, and a pronoun
  head never has describers.
- A `possessor` before a `nominal` in `base` is a possessor (§8.8.1). A
  `"dei"` `link` is a linking pronoun: everything before it is the possessor
  of the `nominal` after it. An `"a"` `link` is the measure link: everything
  before it is the unit, and the `nominal` after it is the kind (§8.12).
- `"sef" "dem"` is the reciprocal "each other" (§7.9).
- Links nest to the left: in `A dei B dei C`, `A dei B` is the possessor of
  `C` (§8.8.7), and in `A dei B a C`, `A dei B` is the unit of `C`
  (§8.12.8). A determiner belongs to the first `nominal` (§8.8.6).
- After `"bi"`, adjectives are a predicate (`adjective+`) only when no noun or
  pronoun follows them; otherwise they begin a noun phrase (§12.2.3).
- Constraints not shown by the rules above:
  - a `nominal` whose `count` is `"wan"` alone, `"eri"` or `"notin"` has no
    `"dem"` (§8.5.3);
  - a `nominal` whose `count` is a `number` above one, `"al"`, `"som"`,
    `"nof"` or `"fiu"` has `"dem"`, whether its head is a noun or a pronoun
    (§8.5.2, §8.10.2, §19.3);
  - `"sef"` never has a `count`, and `"sef" "dem"` appears only in a command
    or a clause with a plural subject (§7.9, §8.10.4);
  - `"sef"` and `"sef" "dem"` never appear inside the subject `noun-phrase`
    of their own `statement` (§7.7.1);
  - the `nominal` after a `determiner`, `possessor` or `link` has a noun as
    its head (§8.8, §8.10.1);
  - the phrase before a `link` does not have a pronoun as its head (§8.8.9);
  - the phrase before an `"a"` is not a `standalone`, and the `nominal` after
    an `"a"` has no `count` (§8.12.6, §8.12.7);
  - a number begins with `"ziro"` only if it is `"ziro"` alone (§19.1.3);
  - a sentence containing a command does not contain `"wa"` (§15.4);
  - a sentence containing `"wa"` does not end in the question marker `"no"`
    (§15.2.6);
  - a sentence ends in `"?"` or `"?!"` exactly when it is a question (§5.2).
