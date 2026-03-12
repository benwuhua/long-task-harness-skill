# Artifact Layout Scaffold Design

## Goal

Make the initialized project skeleton visibly express the expected evidence layout by creating standard `artifacts/` subdirectories with `README.md` placeholders.

## Scope

This design covers:

- deterministic scaffold changes in `skills/long-task-init/scripts/init_project.py`
- test coverage for artifact subdirectory creation
- keeping initializer-facing messaging aligned with the new scaffold

This design does not cover:

- project-specific retention policies
- new automation scripts for artifact capture
- root repository restructuring outside the initializer workflow

## Problem

The initializer now creates `artifacts/README.md`, but the evidence layout is still only implied. Freshly initialized projects do not visibly separate:

- service and test logs
- reports
- screenshots
- traces
- reproduction bundles

That makes the harness less concrete than it should be. Workers still have to infer where specific evidence should land.

## Requirements

### Functional

1. `init_project.py` must create these artifact subdirectories:
   - `artifacts/logs/`
   - `artifacts/reports/`
   - `artifacts/screenshots/`
   - `artifacts/traces/`
   - `artifacts/reproductions/`
2. Each subdirectory must contain a `README.md` placeholder describing its purpose.
3. `artifacts/README.md` must describe the standard layout so the root and subdirectories remain consistent.
4. Initializer-facing tests must verify the directories and placeholder files.

### Non-Functional

1. The placeholders must stay generic and safe to trust.
2. The new structure must be deterministic.
3. The change must not introduce project-specific assumptions about tooling.

## Approaches

### Approach A: Create empty directories only

Pros:

- Lowest implementation cost

Cons:

- Leaves directory semantics implicit
- Still forces users to infer where evidence belongs

### Approach B: Create directories plus README placeholders

Pros:

- Makes the intended layout self-describing
- Matches the requested scope exactly
- Keeps project-specific details out of the deterministic scaffold

Cons:

- Adds a few more generated files

### Approach C: Create directories plus extra automation files

Pros:

- Strongest operational guidance

Cons:

- Too heavy for this step
- Risks baking in assumptions before the project design is known

## Decision

Adopt Approach B.

The deterministic scaffold should define a standard artifact layout and explain it with lightweight placeholders.

## Design

### Generated Structure

`init_project.py` should create this structure:

```text
artifacts/
  README.md
  logs/README.md
  reports/README.md
  screenshots/README.md
  traces/README.md
  reproductions/README.md
```

### Placeholder Semantics

- `logs/README.md`: service logs, test logs, diagnosis output
- `reports/README.md`: test reports, coverage reports, verification summaries
- `screenshots/README.md`: UI evidence, captured states, visual regressions
- `traces/README.md`: network traces, performance traces, debug captures
- `reproductions/README.md`: minimal repro inputs, scripts, payloads, seed bundles

These files must describe purpose only. They must not pretend to contain project-specific commands or policies.

### Root Artifacts README

Update the generated `artifacts/README.md` content so it lists the standard subdirectories explicitly and points readers at the per-directory placeholders.

### Test Changes

Extend `tests/test_init_project.py` to assert:

- the five subdirectories exist
- each subdirectory contains `README.md`
- the content roughly matches the intended evidence type

### Initializer Messaging

Update the closing initializer output so it mentions that the deterministic scaffold now includes the standard `artifacts/` evidence layout.

## Risks

### Risk: Placeholder content becomes noisy boilerplate

Mitigation:

- Keep each README short and purpose-focused.

### Risk: The root artifacts README drifts from the generated layout

Mitigation:

- Define the layout in one place in the generator and lock it with tests.

## Outcome

A newly initialized project will show a clear, self-describing evidence layout from the first scaffold run, making harness expectations more concrete for future workers.
