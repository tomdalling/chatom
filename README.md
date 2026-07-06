Astu
=====

Ash v2. Another attempt at a machine-parsable human language. Think esperanto,
but invented by a software engineer.

Aims
----

1. Astu text should be parsable into an AST with no ambiguity.
1. The alphabet is phonetic. Knowing how a word is spelled tells you exactly how
   it is pronounced, and vice versa.

Running
-------

This is a static, single-page website with no build step: plain HTML, CSS, and
JavaScript (ES modules). Serve the directory over HTTP and open `index.html`:

```
python3 -m http.server
```

Then visit http://localhost:8000. A local server is required because the app
`fetch()`es `data/dictionary.txt`, which browsers block when opening
`index.html` directly via `file://`.

The site has four tabs, mirroring the old CLI:

- **Lookup** an Astu word by exact match.
- **Search** for Astu words by English meaning.
- **List** all dictionary entries, optionally filtered by part of speech.
- **Parse** an Astu sentence (subject verb object) into an English gloss and
  an XML AST.

Code layout
-----------

- `data/dictionary.txt` — the dictionary source data (word, part of speech,
  English definition, optional description).
- `js/dictionary.js` — parses the dictionary file and supports lookup/search/list.
- `js/ipa.js` — converts Astu spelling to IPA notation.
- `js/parser.js` — parses an Astu sentence into an AST.
- `js/ast/` — AST node classes (`Clause`, `NounPhrase`, `VerbPhrase`, `Noun`,
  `Verb`, `Adjective`).
- `js/xml.js` — tiny XML element/pretty-printer used to render the AST.
- `js/app.js` — wires the above up to `index.html`.
