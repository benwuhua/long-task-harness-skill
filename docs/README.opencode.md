# Long-Task Harness Skill for OpenCode

This repository installs the `long-task` skill namespace and the OpenCode plugin from `benwuhua/long-task-harness-skill`.

## One-Command Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.sh | bash
```

### Windows PowerShell

Requires Developer Mode or Administrator for the plugin symlink.

```powershell
irm https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.ps1 | iex
```

Restart OpenCode after installation.

## Manual Install

### macOS / Linux

```bash
if [ -d ~/.config/opencode/long-task-harness-skill/.git ]; then
  git -C ~/.config/opencode/long-task-harness-skill pull --ff-only
else
  git clone https://github.com/benwuhua/long-task-harness-skill.git ~/.config/opencode/long-task-harness-skill
fi

mkdir -p ~/.config/opencode/plugins ~/.config/opencode/skills
rm -f ~/.config/opencode/plugins/long-task.js
rm -rf ~/.config/opencode/skills/long-task

ln -s ~/.config/opencode/long-task-harness-skill/.opencode/plugins/long-task.js ~/.config/opencode/plugins/long-task.js
ln -s ~/.config/opencode/long-task-harness-skill/skills ~/.config/opencode/skills/long-task
```

### Windows PowerShell

```powershell
if (Test-Path "$env:USERPROFILE\.config\opencode\long-task-harness-skill\.git") {
  git -C "$env:USERPROFILE\.config\opencode\long-task-harness-skill" pull --ff-only
} else {
  git clone https://github.com/benwuhua/long-task-harness-skill.git "$env:USERPROFILE\.config\opencode\long-task-harness-skill"
}

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\plugins" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills" | Out-Null

Remove-Item "$env:USERPROFILE\.config\opencode\plugins\long-task.js" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\.config\opencode\skills\long-task" -Force -Recurse -ErrorAction SilentlyContinue

New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.config\opencode\plugins\long-task.js" `
  -Target "$env:USERPROFILE\.config\opencode\long-task-harness-skill\.opencode\plugins\long-task.js" | Out-Null

New-Item -ItemType Junction `
  -Path "$env:USERPROFILE\.config\opencode\skills\long-task" `
  -Target "$env:USERPROFILE\.config\opencode\long-task-harness-skill\skills" | Out-Null
```

## Verification

macOS / Linux:

```bash
ls -l ~/.config/opencode/plugins/long-task.js
ls -l ~/.config/opencode/skills/long-task
```

Windows PowerShell:

```powershell
Get-ChildItem "$env:USERPROFILE\.config\opencode\plugins" | Where-Object { $_.LinkType }
Get-ChildItem "$env:USERPROFILE\.config\opencode\skills" | Where-Object { $_.LinkType }
```

## Update

```bash
git -C ~/.config/opencode/long-task-harness-skill pull --ff-only
```

## Troubleshooting

- If the plugin symlink fails on Windows, enable Developer Mode or run PowerShell as Administrator.
- If OpenCode does not see the skills, verify the `long-task` directory link and restart OpenCode.
- If you updated the repo but behavior did not change, restart OpenCode so the plugin reloads.
