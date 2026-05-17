@doc/activity.md @doc/todo

First read `doc/activity.md` to see what was recently accomplished.

## Work on Tasks

Work out the next thing to do by looking in the `doc/todo` directory. Check the
`status` of each documet here and:

- when `draft` or no status present, then IGNORE this file and DO NOT work
  on it.
- when `ready` then this task is ready to be worked on
- when `done` then this task is completed, and can be double checked for
  completion
- when `done_done` then this task is considered fully completed, and should be
  ignored.

Work on exactly ONE thing:
1. Implement the change according to the given information
2. Run any available checks, such as tests or the CLI

## Log Progress

Append a dated progress entry to `doc/activity.md` describing:
- What you changed
- What commands you ran
- The screenshot filename
- Any issues encountered and how you resolved them

## Update Task Status

When the task is confirmed working, update that task's `status` field to
`done`.

If you've doubled checked that a task is done, update it's status to
`done_done`.

## Commit Changes

After completing one change, commit it all to git with a clear, descriptive
message.

## Important Rules

- ONLY work on a SINGLE task per iteration
- Always log your progress in activity.md
- Always commit after completing a task

## Completion

When ALL tasks are `done_done`, output:

<promise>COMPLETE</promise>
