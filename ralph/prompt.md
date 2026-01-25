# Ralph Agent Instructions

## Your Task
1. Find the highest-priority task and implement it.
- To find tasks, search linear for tasks with the label 'ralph'
2. Read `@scripts/ralph/progress.txt`
   (check Codebase Patterns first)
3. Check you're on the correct branch
- If not on the correct branch, create a branch for the current task
4. Pick highest priority story where `passes: false`
5. Implement that ONE story
6. Add tests to ensure changes work
7. Run typecheck and tests
- `mix compile --warnings-as-errors`
- `cd assets && npm run typecheck`
8. Update `@scripts/ralph/RALPH_AGENTS.md` files with learnings
9. Commit: `feat: [ID] - [Title]`
10. Append learnings to `@scripts/ralph/progress.txt`
11. Update the linear task with context related to your changes
12. Create a PR: RALPH: `[ID] - [Title]`

## Progress Format

APPEND to `@scripts/ralph/progress.txt`:

## [Date] - [Story ID]
- What was implemented
- Files changed
- **Learnings:**
  - Patterns discovered
  - Gotchas encountered
---

## Codebase Patterns

Add reusable patterns to the TOP 
of `@scripts/ralph/progress.txt`:

## Stop Condition

If ALL stories pass, reply:
<promise>COMPLETE</promise>

Otherwise end normally.
