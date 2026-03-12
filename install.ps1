# Long-Task Harness Skill installer for OpenCode (Windows PowerShell)
# Usage: irm https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.ps1 | iex
#
# Requirements: Developer Mode enabled or Administrator privileges for the plugin symlink.

$ErrorActionPreference = "Stop"

$installDir = "$env:USERPROFILE\.config\opencode\long-task-harness-skill"
$pluginsDir = "$env:USERPROFILE\.config\opencode\plugins"
$skillsDir = "$env:USERPROFILE\.config\opencode\skills"
$repoUrl = "https://github.com/benwuhua/long-task-harness-skill.git"

Write-Host "Installing long-task-harness-skill for OpenCode..."

if (Test-Path (Join-Path $installDir ".git")) {
    Write-Host "  -> Updating existing installation..."
    git -C $installDir pull --ff-only
} else {
    Write-Host "  -> Cloning repository..."
    git clone $repoUrl $installDir
}

New-Item -ItemType Directory -Force -Path $pluginsDir | Out-Null
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null

$pluginLink = Join-Path $pluginsDir "long-task.js"
$skillLink = Join-Path $skillsDir "long-task"

if (Test-Path $pluginLink) { Remove-Item $pluginLink -Force }
if (Test-Path $skillLink) { Remove-Item $skillLink -Force -Recurse }

New-Item -ItemType SymbolicLink `
    -Path $pluginLink `
    -Target (Join-Path $installDir ".opencode\plugins\long-task.js") | Out-Null

New-Item -ItemType Junction `
    -Path $skillLink `
    -Target (Join-Path $installDir "skills") | Out-Null

Write-Host ""
Write-Host "Done."
Write-Host "  Plugin: $pluginLink"
Write-Host "  Skills: $skillLink"
Write-Host ""
Write-Host "Restart OpenCode to activate the updated plugin and skills."
