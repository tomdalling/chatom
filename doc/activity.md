## 2026-05-17

Implemented `help_option` task (status: ready → done_done).

- Updated `lib/ashtu/cli.rb`: base `run` now handles `-h`/`--help` flags; `lookup` and `search` subcommands each show their own usage when called with `-h`, `--help`, or no arguments.
- Added 7 new tests in `spec/ashtu/cli_spec.rb` covering `-h`/`--help` for base, lookup, and search.
- Ran `bundle exec rspec`: 18 examples, 0 failures.
- Manually verified `./bin/ashtu --help`, `./bin/ashtu lookup --help`, `./bin/ashtu search -h` — all print correct usage text.
- No issues encountered.

Verified `dictionary_cli` task (status: done → done_done).

- Reviewed `lib/ashtu/dictionary.rb` (Dictionary class with `lookup` and `search`) and `lib/ashtu/cli.rb` (CLI with `lookup`/`search` subcommands).
- Ran `bundle exec rspec`: 11 examples, 0 failures.
- Ran `./bin/ashtu lookup dog` → `dog [noun] dog`.
- Ran `./bin/ashtu search fire` → `faia [noun] fire`, `smoke [noun] of fire`.
- No issues. All dictionary CLI functionality confirmed working.
