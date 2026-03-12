# Harness Surface Visibility Design

## Goal

Make `long-task-harness-skill` visibly embody harness engineering at the repository surface instead of only inside skill internals.

## Scope

This design covers:

- Top-level documentation that explains the harness-first philosophy
- Template assets that make harness artifacts concrete and reusable
- Default repository structure for runbooks and evidence artifacts
- Lightweight verification that these surface assets remain present

This design does not cover:

- Rewriting long-task phase behavior
- Adding new automation gates or new runtime dependencies
- Turning the repository into a full sample application

## Problem

The current repository packages long-task successfully across Claude Code, OpenCode, and Codex, but the visible repository surface still reads like a distribution bundle. Harness engineering is documented inside skill references, yet users landing on the repository do not immediately see:

- what harness engineering means in this product
- which repo-local assets represent the harness
- which files an initialized project should maintain

This weakens the repository's identity and makes the packaging claim harder to verify by inspection.

## Requirements

### Functional

1. The root README files must explicitly describe harness engineering as part of the product.
2. The repository must include a dedicated harness engineering document at `docs/HARNESS_ENGINEERING.md`.
3. The repository must expose reusable templates for core harness assets:
   - `env-guide.md`
   - `long-task-guide.md`
   - runbooks
   - artifact index/readme
4. The repository must include visible landing locations for runbooks and artifacts.

### Non-Functional

1. The solution must stay lightweight and documentation-first.
2. The new assets must be directly useful to users and agents, not just marketing copy.
3. Verification should stay simple: presence checks plus README references.

## Approaches

### Approach A: README-only messaging

Add a short harness section to the existing README files.

Pros:

- Fastest change
- Minimal repository churn

Cons:

- Still mostly rhetorical
- Does not provide reusable harness assets

### Approach B: Surface the harness as first-class repository assets

Add README coverage plus a dedicated harness document, new templates, and default runbook/artifact directories.

Pros:

- Makes the philosophy visible by inspection
- Gives users concrete files to copy into real projects
- Keeps the repository lightweight

Cons:

- Adds more docs to maintain

### Approach C: Full demo project

Add a sample project that fully implements the harness pattern.

Pros:

- Strongest demonstration

Cons:

- Heavyweight
- Risks confusing example code with required product structure

## Decision

Adopt Approach B.

This repository should demonstrate harness engineering through concrete repository assets, not just explanatory prose.

## Design

### README Changes

Update `README.md` and `README_EN.md` so the repository describes itself as a harness-first workflow package. Each README should explain:

- the repository is the harness, not just a skill bundle
- the expected repo-local assets used to control and debug agent work
- where to find the dedicated harness documentation and templates

### Dedicated Harness Document

Create `docs/HARNESS_ENGINEERING.md` as the durable explanation of:

- the core rule: if work depends on oral context or manual dashboards, the harness is incomplete
- common symptoms that indicate a harness gap
- the preferred repo-local assets
- maintenance rules for keeping harness assets current

This document should be adapted for repository consumers, not written as an internal-only skill note.

### Template Set

Create these new files under `docs/templates/`:

- `env-guide-template.md`
- `long-task-guide-template.md`
- `runbook-template.md`
- `artifacts-readme-template.md`

These templates should be practical starter content, not placeholders with no guidance. They should show how to document deterministic setup, operator workflow, diagnosis/recovery, and evidence storage.

### Visible Harness Structure

Create two concrete landing locations in the repository:

- `docs/runbooks/README.md`
- `artifacts/README.md`

These files act as visible structure markers so users can see where operational knowledge and captured evidence belong.

### Verification

Add a packaging-level test that asserts:

- README files mention harness engineering
- the harness document exists
- the new templates exist
- the runbook and artifacts landing files exist

The goal is not heavy enforcement. It is to prevent the surface-level harness story from disappearing again.

## Risks

### Risk: The change turns into branding copy

Mitigation:

- Keep every new document tied to a reusable file or directory structure.

### Risk: Templates drift from long-task expectations

Mitigation:

- Reuse language already present in long-task references where practical.
- Keep templates generic enough to remain valid across stacks.

## Outcome

After this change, a user inspecting the repository root and `docs/` directory should immediately understand that `long-task-harness-skill` is a harness-first engineering package, and should find concrete starter assets that express that philosophy.
