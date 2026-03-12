# Init Harness Scaffold Design

## Goal

Make the initialized project skeleton visibly harness-first by creating the minimum repo-local harness structure during `long-task-init`.

## Scope

This design covers:

- deterministic scaffold changes in `skills/long-task-init/scripts/init_project.py`
- project skeleton additions for runbooks and artifacts
- test coverage for the new scaffold structure

This design does not cover:

- generating project-specific `env-guide.md`
- generating project-specific `long-task-guide.md`
- generating real runbook content
- adding new runtime scripts or automation gates

## Problem

The repository now presents harness engineering clearly at the distribution surface, but newly initialized projects still start from a thinner scaffold:

- `feature-list.json`
- `task-progress.md`
- `RELEASE_NOTES.md`
- `examples/`
- `docs/plans/`

This means the initializer text asks for harness assets that the deterministic scaffold does not expose yet. A fresh project therefore looks only partially harness-first until later LLM-authored steps run.

## Requirements

### Functional

1. `init_project.py` must create a visible runbook directory with a README placeholder.
2. `init_project.py` must create a visible artifacts directory with a README placeholder.
3. The generated placeholder files must describe purpose only, not pretend to contain project-specific commands or runbooks.
4. The existing deterministic scaffold behavior must remain unchanged for all current outputs.

### Non-Functional

1. The change must stay minimal and deterministic.
2. The scaffold must avoid generating misleading empty operational docs.
3. Existing initialized projects must remain compatible.

## Approaches

### Approach A: Add directory markers only

Create:

- `docs/runbooks/README.md`
- `artifacts/README.md`

Pros:

- Matches the requested scope exactly
- Makes harness structure visible immediately
- Avoids fake project-specific content

Cons:

- The actual operational docs still arrive later in the init phase

### Approach B: Add directory markers plus empty guide files

Create the two README markers and also create blank `env-guide.md` / `long-task-guide.md`.

Pros:

- More files visible on day one

Cons:

- Creates untrustworthy shell files that look authoritative but are not
- Conflicts with the current split between deterministic scaffold and LLM-authored project docs

### Approach C: Leave initializer unchanged

Rely on README guidance and later LLM-authored assets only.

Pros:

- No code changes

Cons:

- Leaves the harness-first gap unresolved in freshly initialized projects

## Decision

Adopt Approach A.

The deterministic scaffold should create only structure markers that are always true and safe to trust.

## Design

### Scaffold Changes

Extend `skills/long-task-init/scripts/init_project.py` to always create:

- `docs/runbooks/README.md`
- `artifacts/README.md`

These files should be generated alongside the existing deterministic scaffold outputs.

### Content Rules

`docs/runbooks/README.md` should:

- state that `docs/runbooks/` holds diagnosis and recovery runbooks
- direct later workers to add one markdown file per recurring failure mode or operational workflow

`artifacts/README.md` should:

- state that `artifacts/` holds durable evidence such as logs, screenshots, traces, and reports
- provide a lightweight suggested structure

Neither file should claim to know project-specific commands, services, or workflows.

### Test Changes

Extend `tests/test_init_project.py` so the initializer must now produce:

- the `docs/runbooks/` directory and its README
- the `artifacts/` directory and its README

This keeps the new scaffold requirement mechanically enforced.

## Compatibility

- Existing generated files remain unchanged.
- Existing projects are unaffected unless `init_project.py` is run again in a new directory.
- The change aligns the deterministic scaffold more closely with `long-task-init/SKILL.md` without collapsing the distinction between scaffolded placeholders and later project-specific docs.

## Risks

### Risk: The new placeholders become stale boilerplate

Mitigation:

- Keep them purpose-only and short.
- Do not duplicate project-specific content that belongs in later generated docs.

### Risk: Users interpret README markers as complete harness docs

Mitigation:

- Explicitly describe them as placeholders and structure markers.

## Outcome

A freshly initialized project will immediately show a harness-oriented directory structure, while keeping project-specific operational content in later initializer steps where it can be generated accurately.
