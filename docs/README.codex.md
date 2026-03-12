# Long-Task Harness Skill for Codex

This repository installs the `long-task` skills for Codex through Codex's native skill discovery.

## Quick Install

Tell Codex:

```text
Fetch and follow instructions from https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/.codex/INSTALL.md
```

## Manual Install

### macOS / Linux

```bash
if [ -d ~/.codex/long-task-harness-skill/.git ]; then
  git -C ~/.codex/long-task-harness-skill pull --ff-only
else
  git clone https://github.com/benwuhua/long-task-harness-skill.git ~/.codex/long-task-harness-skill
fi

mkdir -p ~/.agents/skills
rm -rf ~/.agents/skills/long-task
ln -s ~/.codex/long-task-harness-skill/skills ~/.agents/skills/long-task
```

### Windows PowerShell

```powershell
if (Test-Path "$env:USERPROFILE\.codex\long-task-harness-skill\.git") {
  git -C "$env:USERPROFILE\.codex\long-task-harness-skill" pull --ff-only
} else {
  git clone https://github.com/benwuhua/long-task-harness-skill.git "$env:USERPROFILE\.codex\long-task-harness-skill"
}

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills" | Out-Null
if (Test-Path "$env:USERPROFILE\.agents\skills\long-task") {
  Remove-Item "$env:USERPROFILE\.agents\skills\long-task" -Force -Recurse
}
New-Item -ItemType Junction `
  -Path "$env:USERPROFILE\.agents\skills\long-task" `
  -Target "$env:USERPROFILE\.codex\long-task-harness-skill\skills" | Out-Null
```

## Optional Collab Support

Some long-task flows benefit from Codex collaborative agents. If you use those flows, add this to `~/.codex/config.toml`:

```toml
[features]
collab = true
```

## Verification

```bash
ls -la ~/.agents/skills/long-task
ls ~/.codex/long-task-harness-skill/skills
```

Restart Codex after installation so skill discovery refreshes.

## Update

```bash
git -C ~/.codex/long-task-harness-skill pull --ff-only
```
