# Runbook Index Scaffold Design

## Goal

Make the initialized project skeleton visibly express expected runbook coverage without generating fake project-specific runbooks.

## Scope

This design covers:

- deterministic scaffold changes in `skills/long-task-init/scripts/init_project.py`
- test coverage for runbook index files
- initializer-facing messaging in `long-task-init`

This design does not cover:

- generating concrete `startup.md`, `recovery.md`, or `diagnosis.md` runbooks
- adding new runbook validation scripts
- root repository documentation outside the initializer workflow

## Problem

The initializer currently creates only `docs/runbooks/README.md`.

That gives users a directory marker, but it does not clearly express:

- which runbook themes are expected in a harness-first project
- how later initializer steps or workers should fill them in

At the same time, generating fake files such as `startup.md` or `recovery.md` would be misleading because deterministic scaffold cannot know the project's actual services, failure modes, or recovery paths.

## Requirements

### Functional

1. `init_project.py` must create:
   - `docs/runbooks/README.md`
   - `docs/runbooks/INDEX.md`
   - `docs/runbooks/TOPICS.md`
2. `INDEX.md` must explain how concrete runbooks should be added and referenced.
3. `TOPICS.md` must list suggested runbook themes without pretending they are already implemented.
4. Initializer tests must verify the new files and their basic content.

### Non-Functional

1. The new files must stay generic and truthful.
2. The scaffold must not imply that project-specific operational procedures are already written.
3. The change must remain lightweight.

## Approaches

### Approach A: Keep only `README.md`

Pros:

- Lowest complexity

Cons:

- Does not make expected runbook coverage visible

### Approach B: Generate concrete placeholder runbooks such as `startup.md` and `recovery.md`

Pros:

- Highly visible

Cons:

- Misleading because deterministic scaffold cannot know real commands or recovery flows

### Approach C: Generate runbook index files, not fake runbooks

Pros:

- Makes expected themes visible
- Avoids pretending operational docs already exist
- Matches the requested harness-first intent

Cons:

- Slightly more structure to maintain

## Decision

Adopt Approach C.

The deterministic scaffold should provide a truthful runbook index, not fake runbooks.

## Design

### Generated Structure

`init_project.py` should create:

```text
docs/runbooks/
  README.md
  INDEX.md
  TOPICS.md
```

### File Semantics

- `README.md`: explains the directory purpose and points readers to the template
- `INDEX.md`: explains how to list and link concrete runbooks as they are added
- `TOPICS.md`: lists suggested runbook themes, for example:
  - startup / bootstrapping
  - diagnosis / triage
  - recovery / reset
  - dependency outage
  - seeded reproduction

These files must clearly indicate that concrete runbooks are still to be written based on the actual project design.

### Skill And Output Messaging

Update `skills/long-task-init/SKILL.md` so the deterministic scaffold description mentions `INDEX.md` and `TOPICS.md` as runbook structure markers.

Update `init_project.py` output so the created scaffold summary mentions the runbook index files.

### Test Changes

Extend `tests/test_init_project.py` so it asserts:

- `docs/runbooks/INDEX.md` exists
- `docs/runbooks/TOPICS.md` exists
- `INDEX.md` mentions index/listing intent
- `TOPICS.md` mentions the suggested themes

## Risks

### Risk: Index files become stale

Mitigation:

- Keep them generic and avoid project-specific content.

### Risk: Users mistake `TOPICS.md` for implemented runbooks

Mitigation:

- Explicitly state that it lists suggested themes and that concrete runbooks must still be added.

## Outcome

A newly initialized project will show a truthful runbook structure: enough to reveal expected operational coverage, without fabricating project-specific procedures.
