Phonemes & Graphemes
====================

The sounds that make up words. This is a phonetic language, so phonemes have a
1:1 mapping to graphemes.

Vowels
------

There are 5 vowels in the language. These are close to the five vowels found in
Japanese.

1. /i/ --- close, front, unrounded
2. /e/ --- mid, front, unrounded
3. /a/ --- open, front, unrounded
4. /u/ --- close, back, rounded
5. /o/ --- mid, back, rounded


Chart:

```txt
       Front      Back
Close   /i/-------/u/
          \        |
           \       |
Mid        /e/----/o/
             \     |
              \    |
Open          /a/--|
```


Consonants
----------

Consonants are categorised into _voiced_ and _unvoiced_. These are mostly taken
from English, with the exception of /zh/ which is taken from Chinese.

    | Voiced | Voiceless |
    |--------|-----------|
    |  /b/   |    /p/    |
    |  /d/   |    /t/    |
    |  /g/   |    /k/    |
    |  /v/   |    /f/    |
    |  /z/   |    /s/    |
    |  /zh/  |    /sh/   |
    |  /jh/  |    /ch/   |
    |  /m/   |     -     |
    |  /n/   |     -     |
    |  /nh/  |     -     |
    |  /l/   |     -     |
    |  /r/   |     -     |
    |  /w/   |     -     |

There is not `/h/` phoneme, but the letter `h` is used after another letter to
identify some of the phonemes. The `/nh/` phoneme is the "ng" in "sing", but is
not "/ng/" to avoid ambiguity with the `/n/` and `/g/` phonemes.


Phonotactics
------------

All words begin with a consonant, and then alternate: consonant, vowel,
consonant, vowel, etc. Words must also end with a consonant. Starting and ending
with a consonant should make it easier to hear word boundaries.

TODO: Should I allow some classes of words to start or end with a vowel?

TODO: Remove alternating consonants and vowels?


Relation To Grammar
-------------------

Certain classes of words can be identified by the first phoneme/grapheme.

- All verbs start with a voiceless consonant
- All nouns start with a voiced consonant
- TODO: Reserve `/m/`, `/n/`, `/g/`, etc. for particles or some such?

Romanisation
------------

The graphemes are designed for easy romanisation. For example:


