# Install Long-Task Harness Skill For Codex

Install the packaged `long-task` skills from `benwuhua/long-task-harness-skill`.

## macOS / Linux

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

## Windows PowerShell

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

## Optional

If you use Codex collaborative flows, add this to `~/.codex/config.toml`:

```toml
[features]
collab = true
```

Restart Codex after installation.
