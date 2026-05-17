---
status: done_done
---

Add an `ashtu list` subcommand that lists all dictionary entries.

## Usage

```
ashtu list                  # all words
ashtu list --pos noun       # only nouns
ashtu list --pos verb       # only verbs
ashtu list -h / --help      # usage
```

## Output format

Same as `lookup`/`search`: one entry per line using `format_entry`.

## Implementation

Add a `list` case in `CLI#run` and a private `list` method. Parse the optional
`--pos <value>` flag from args. Pass it through to a new `Dictionary#list` method:

```ruby
# returns all entries, or filtered by part_of_speech if pos: is given
def list(pos: nil)
  pos ? @entries.select { _1.part_of_speech == pos } : @entries
end
```

Add `-h`/`--help` support matching the existing subcommand pattern.

## Acceptance criteria

- `./bin/ashtu list` prints all dictionary entries.
- `./bin/ashtu list --pos noun` prints only noun entries.
- `./bin/ashtu list --pos verb` prints only verb entries.
- `./bin/ashtu list --pos unknown_pos` prints nothing (no error).
- `./bin/ashtu list -h` prints usage.
- Unit tests for the new `Dictionary#list` method and CLI behaviour.
- All existing tests still pass.
