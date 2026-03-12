# Init Harness Messaging Design

## Goal

Make the `long-task-init` documentation and deterministic initializer output explain the new harness scaffold clearly, especially the boundary between structure markers and later project-specific docs.

## Scope

This design covers:

- `skills/long-task-init/SKILL.md`
- `skills/long-task-init/scripts/init_project.py` terminal output
- tests that lock the expected messaging

This design does not cover:

- root README changes
- new scaffold directories or files
- generating additional project documents

## Problem

The initializer now creates harness structure markers:

- `docs/runbooks/README.md`
- `artifacts/README.md`

But the main initializer-facing explanations still blur the boundary between:

- deterministic scaffold outputs that are always safe and generic
- later project-specific docs that must be generated from the actual SRS and design

As a result, users can see the new directories but still lack a clean explanation of:

- why they already exist
- what they are for
- which docs are still pending later in the initializer flow

## Requirements

### Functional

1. `long-task-init/SKILL.md` must mention the new harness structure markers in the deterministic scaffold step.
2. `long-task-init/SKILL.md` must explain that these markers are placeholders, not complete project-specific operational docs.
3. `init_project.py` output must distinguish between:
   - what was created deterministically
   - what still needs to be generated later in the initializer phase
4. The later-generated list must explicitly include `env-guide.md` alongside `long-task-guide.md` and `init.sh` / `init.ps1`.

### Non-Functional

1. The messaging must stay concise.
2. The boundary between scaffolded markers and project-specific docs must be unambiguous.
3. The new wording should align with the existing harness-first philosophy.

## Approaches

### Approach A: Minimal list patch

Only update the `Creates:` list in `long-task-init/SKILL.md` and add one extra line to `init_project.py` output.

Pros:

- Smallest possible change

Cons:

- Does not clearly explain the two-layer model

### Approach B: Two-layer messaging

Update both the skill and initializer output to explicitly separate deterministic scaffold assets from later generated project docs.

Pros:

- Best clarity for users
- Matches the current architecture
- Stays lightweight

Cons:

- Slightly more wording to maintain

### Approach C: Broader repo-wide messaging pass

Also update root README and cross-platform docs.

Pros:

- Maximum consistency

Cons:

- Unnecessary for the requested scope

## Decision

Adopt Approach B.

The messaging should explain the initializer as a two-layer process: safe scaffold first, project-specific docs second.

## Design

### Skill Document Changes

Update Step 2 in `skills/long-task-init/SKILL.md` so the deterministic scaffold list includes:

- `docs/runbooks/README.md`
- `artifacts/README.md`

Add a short note clarifying:

- these are harness structure markers
- they are intentionally generic
- later steps still generate `env-guide.md`, `long-task-guide.md`, and project-specific runbooks where needed

### Initializer Output Changes

Update the closing output in `skills/long-task-init/scripts/init_project.py` so it prints two explicit groups:

1. `Created deterministic scaffold:` followed by the generic artifacts and directories
2. `Still to generate during Initializer phase:` followed by project-specific docs

The second group should explicitly include:

- `long-task-guide.md`
- `env-guide.md`
- `init.sh / init.ps1`
- project-specific runbooks when required by the design

### Test Changes

Extend `tests/test_init_project.py` so initializer stdout must mention:

- deterministic scaffold
- runbooks/artifacts structure
- `env-guide.md`

This prevents future regressions where the scaffold exists but the user-facing explanation drifts.

## Risks

### Risk: Over-explaining a simple scaffold step

Mitigation:

- Keep the new text short and operational.

### Risk: Users misread placeholders as complete docs

Mitigation:

- Explicitly call them structure markers or placeholders.

## Outcome

A user running `init_project.py` or reading `long-task-init/SKILL.md` will immediately understand which harness assets already exist, why they exist, and which project-specific docs must still be generated later in the initializer flow.
