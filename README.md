Chatom
======

Ash v2. Another attempt at a machine-parsable human language. Think esperanto,
but invented by a software engineer.

Aims
----

1. Chatom text should be parsable into an AST with no ambiguity.
1. The alphabet is phonetic. Knowing how a word is spelled tells you exactly how
   it is pronounced, and vice versa.

Specification
-------------

[`chatom.md`](chatom.md) is the complete specification of the grammar and function
words, and the source of truth for the language.

Dictionary
----------

`dictionary.sqlite` holds every Chatom word. Look words up with `bin/lookup`:

```sh
bin/lookup dag niam
bin/lookup "dag niam fish."
bin/lookup --json diniam   # machine-readable
```
