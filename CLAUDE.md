# CLAUDE.md

This repository packages the `long-task` workflow as a standalone distribution for Claude Code, OpenCode, and Codex.

## Working Model

- Treat `~/.claude/plugins/marketplaces/long-task-dev` as the packaging skeleton source.
- Treat `~/.codex/skills/using-long-task` and `~/.codex/skills/long-task-*` as the latest skill-content source.
- Keep the shipped product name as `long-task`.
- Keep the GitHub repository identity as `benwuhua/long-task-harness-skill`.
- Do not introduce runtime dependencies on a separate `superpowers` repository.

## Key Paths

- `skills/` — packaged long-task skills
- `commands/` — Claude Code slash commands
- `scripts/` — validators, automation, bootstrap helpers
- `hooks/` — Claude Code hook entrypoints
- `.claude-plugin/` — Claude marketplace metadata
- `.opencode/plugins/long-task.js` — OpenCode plugin entrypoint
- `.codex/INSTALL.md` — Codex install instructions
- `docs/README.opencode.md` — OpenCode guide
- `docs/README.codex.md` — Codex guide

## Important Commands

Run tests:

```bash
python3 -m pytest tests -q
```

Inspect stale repository identity:

```bash
rg -n "suriyel|longtaskforagent|long-task-agent|obra/superpowers" README.md README_EN.md docs/README.opencode.md docs/README.codex.md .claude-plugin .opencode hooks scripts skills tests install.sh install.ps1
```

Inspect skill references:

```bash
rg -n "references/|prompts/" skills
```

## Packaging Rules

- Claude marketplace install must use:
  - `/plugin marketplace add benwuhua/long-task-harness-skill`
  - `/plugin install long-task@long-task-harness-skill`
- OpenCode installers must clone into `~/.config/opencode/long-task-harness-skill`
- Codex installers must clone into `~/.codex/long-task-harness-skill`
- OpenCode and Codex user-facing skill namespace must remain `long-task`

## Verification Before Publish

Before publishing:

1. Run the Python test suite.
2. Audit for stale repo names and local paths.
3. Confirm `.claude-plugin/`, `.opencode/`, and `.codex/INSTALL.md` all agree on repo identity and install paths.
