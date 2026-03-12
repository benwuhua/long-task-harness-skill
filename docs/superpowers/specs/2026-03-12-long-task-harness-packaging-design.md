# Long-Task Harness Packaging Design

## Goal

Package the existing long-task workflow into a standalone public repository named `long-task-harness-skill` that can be installed with one command or one native marketplace flow on Claude Code, OpenCode, and Codex, without requiring a separate `superpowers` installation.

## Scope

This design covers:

- Repository structure for the standalone distribution
- Packaging boundaries between long-task content and vendored shared logic
- Installation and update flows for Claude Code, OpenCode, and Codex
- Verification and release workflow for the new public GitHub repository

This design does not cover:

- Rewriting the long-task workflow itself
- Adding new feature phases to long-task
- Building a new remote marketplace service

## Context

The target directory is currently empty. The existing source material already exists locally in two places:

- `~/.claude/plugins/marketplaces/long-task-dev` contains a working distribution skeleton with marketplace metadata, OpenCode plugin assets, installer scripts, tests, commands, and documentation.
- `~/.codex/skills/long-task-*` and `~/.codex/skills/using-long-task` contain the latest long-task skill content that should be treated as the authoritative skill body when it differs from the cached marketplace copy.

The new repository should be public under `benwuhua/long-task-harness-skill`.

## Requirements

### Functional

1. The repository must expose the long-task workflow as a standalone product.
2. Claude Code users must be able to install the plugin through a repo-backed marketplace flow.
3. OpenCode users must be able to install through `install.sh` on macOS/Linux and `install.ps1` on Windows.
4. Codex users must be able to install through a documented `.codex/INSTALL.md` flow and manual symlink/junction commands.
5. The repo must include all long-task skills, commands, scripts, templates, and platform assets needed for normal use.

### Non-Functional

1. Installation instructions must work on macOS, Linux, and Windows.
2. The repository must not require the user to install `superpowers` separately.
3. The packaged content must stay internally consistent: repo URL, product name, install paths, and command examples must all match the new repo.
4. Local verification must be possible before publishing.

## Approaches

### Approach A: Single standalone distribution repo

Use the existing `long-task-dev` distribution as the base, then update its skills, docs, metadata, and installers so one repository serves all three platforms.

Pros:

- Closest to the required one-click install experience
- Reuses the existing tested distribution layout
- Keeps versioning simple

Cons:

- Requires careful cleanup of stale metadata and implicit dependencies

### Approach B: Split core/content and platform wrappers

Create one repo for long-task content and separate repos or packages for Claude Code, OpenCode, and Codex.

Pros:

- Cleaner internal separation

Cons:

- Worse installation experience
- More maintenance overhead
- Unnecessary for the current goal

### Approach C: Thin wrapper repo with runtime dependency fetch

Keep this repo small and fetch long-task or shared content from other repos during install.

Pros:

- Small repository

Cons:

- Introduces version drift
- Harder to verify
- Violates the standalone packaging goal

## Decision

Adopt Approach A.

The new repository will be a self-contained standalone distribution built from the existing `long-task-dev` packaging skeleton, refreshed with the latest long-task skill content and cleaned of external runtime dependencies.

## Architecture

### Repository Layout

The repository will keep a distribution-first shape:

- `skills/` for the 12 long-task skills and their references
- `commands/` for Claude Code slash commands
- `scripts/` for validators, bootstrap helpers, and automation scripts
- `hooks/` for Claude Code session hooks and Windows hook launchers
- `.claude-plugin/` for Claude marketplace metadata
- `.opencode/plugins/` for the OpenCode plugin
- `.codex/INSTALL.md` for Codex installation
- `docs/` for platform docs and templates
- `tests/` for repository verification
- `install.sh` and `install.ps1` for OpenCode one-command install

### Source of Truth

The source hierarchy will be:

1. `~/.claude/plugins/marketplaces/long-task-dev` for the distribution skeleton
2. `~/.codex/skills/long-task-*` and `~/.codex/skills/using-long-task` for latest skill bodies
3. Existing docs and installers updated in-place for the new repository identity

### Dependency Boundary

The new repo will not depend on a separate `superpowers` checkout at runtime.

Instead:

- Long-task skills remain first-class in `skills/`
- Shared guidance that is actually required at runtime will be localized into long-task-owned references or prompts
- Non-essential superpowers marketplace/plugin content will not be imported

### Platform Installation Model

#### Claude Code

The repository will expose a plugin definition through `.claude-plugin/`.

User flow:

1. Add the repo as a marketplace.
2. Install the `long-task` plugin from that marketplace.

This preserves hooks, slash commands, and native Claude plugin behavior.

#### OpenCode

The repository will keep `.opencode/plugins/long-task.js`.

Installers will:

1. Clone or update the repo into the OpenCode config area.
2. Create or refresh the plugin symlink.
3. Create or refresh the skills symlink/junction.

#### Codex

The repository will add or refresh `.codex/INSTALL.md` so the product can be installed from a raw GitHub URL.

The documented install flow will:

1. Clone or update the repo into a user-local directory.
2. Link `skills/` into `~/.agents/skills/long-task`.
3. Document optional `collab` configuration without mutating the user's config automatically.

## Data and Naming Decisions

- GitHub repository name: `long-task-harness-skill`
- Product/plugin name exposed to users: `long-task`
- Claude marketplace identifier: based on `benwuhua/long-task-harness-skill`
- OpenCode installed skill namespace: `long-task`
- Codex installed skill namespace: `long-task`

This keeps user-facing commands stable while allowing the repository name to describe packaging purpose.

## Migration Plan

1. Copy the `long-task-dev` repository contents into the empty target directory.
2. Overlay current long-task skill directories from `~/.codex/skills`.
3. Audit all paths and docs for old repo names, old install paths, and stale personal references.
4. Localize required shared references instead of leaving runtime dependencies on external repos.
5. Verify tests and installer/docs consistency.

## Verification Strategy

### Content Verification

- Confirm all skill-referenced files exist at the packaged paths.
- Confirm README and platform docs use the new repository URL and identifiers consistently.

### Script Verification

- Run the Python test suite under `tests/`.
- Validate that installer scripts and docs point to correct paths.

### Packaging Verification

- Confirm `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` are coherent.
- Confirm `.opencode/plugins/long-task.js` resolves packaged skills correctly.
- Confirm `.codex/INSTALL.md` matches the packaged layout.

## Risks

### Risk: Cached marketplace copy is stale

Mitigation:

- Overlay skill content from `~/.codex/skills` after importing the skeleton.

### Risk: Hidden references to external repos remain

Mitigation:

- Run a repo-wide search for `superpowers`, old GitHub URLs, and old local paths.

### Risk: Windows install flow breaks due to link semantics

Mitigation:

- Keep junction-based skill installation where possible.
- Reserve symbolic links only for plugin files that require them.
- Document privilege expectations explicitly.

## Testing

- Run `pytest` for packaged Python validation scripts.
- Perform text-level verification on install docs and metadata files.
- Check that the repository is a valid git repo ready to push after content import and cleanup.

## Outcome

The result will be a public, standalone repository that packages long-task as a cross-platform skill/plugin product with native installation stories for Claude Code, OpenCode, and Codex, while minimizing imported shared content to only what is actually required.
