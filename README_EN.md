# Long-Task Harness Skill

`long-task-harness-skill` is a standalone distribution repository for the long-task workflow, packaged for Claude Code, OpenCode, and Codex.

The user-facing product name stays `long-task`, so installed commands, skill names, and namespaces remain stable even though the repository name is `long-task-harness-skill`.

## Quick Install

### Claude Code

Add the marketplace:

```bash
/plugin marketplace add benwuhua/long-task-harness-skill
```

Install the plugin:

```bash
/plugin install long-task@long-task-harness-skill
```

### OpenCode

macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.sh | bash
```

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.ps1 | iex
```

### Codex

Tell Codex:

```text
Fetch and follow instructions from https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/.codex/INSTALL.md
```

## Usage

After installation, describe the project you want to build and mention `long-task` if you want to be explicit.

Example:

```text
I want to build a weather query app. Use long-task.
```

The workflow routes automatically:

```text
Requirements -> UCD (if UI) -> Design -> Init -> Worker cycles -> System Testing
```

Claude Code also exposes shortcut commands:

```text
/long-task:requirements
/long-task:ucd
/long-task:design
/long-task:init
/long-task:work
/long-task:st
/long-task:increment
/long-task:status
```

## Repository Layout

- `skills/`: the 12 long-task skills
- `commands/`: Claude Code slash-command entrypoints
- `scripts/`: validators, bootstrap helpers, automation
- `hooks/`: Claude Code hooks
- `.claude-plugin/`: Claude marketplace metadata
- `.opencode/plugins/`: OpenCode plugin assets
- `.codex/INSTALL.md`: Codex install entrypoint
- `docs/`: platform guides and templates
- `tests/`: Python verification tests

## Core Capabilities

- Multi-session project state persistence
- Requirements / UCD / Design / Init / Work / ST phase routing
- Strict TDD plus coverage and mutation gates
- Per-feature black-box acceptance testing and system-level testing
- Incremental requirements updates with impact analysis
- Unified packaging for Claude Code, OpenCode, and Codex

## Development

Run tests:

```bash
python3 -m pytest tests -q
```

Useful scripts:

```bash
python3 scripts/validate_features.py feature-list.json
python3 scripts/get_tool_commands.py feature-list.json --json
```

Platform guides:

- [OpenCode Guide](docs/README.opencode.md)
- [Codex Guide](docs/README.codex.md)

## Publishing Target

This repository is intended to be published publicly at `benwuhua/long-task-harness-skill`, and all install paths and docs are normalized to that GitHub source.
