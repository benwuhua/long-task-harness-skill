# Long-Task Harness Packaging Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a standalone `long-task-harness-skill` repository from the existing long-task distribution assets, with one-step installation paths for Claude Code, OpenCode, and Codex.

**Architecture:** Import the current `long-task-dev` packaged distribution as the base, then refresh skill content from the latest local long-task sources and normalize all metadata, installers, and docs to the new public GitHub repository. Keep the package self-contained by localizing required shared references instead of depending on an external `superpowers` installation.

**Tech Stack:** Git, shell utilities, Python tests, Claude/OpenCode/Codex packaging metadata

---

## Chunk 1: Scaffold The Repo From Existing Sources

### Task 1: Initialize working structure and inspect source baselines

**Files:**
- Create: `docs/superpowers/specs/2026-03-12-long-task-harness-packaging-design.md`
- Create: `docs/superpowers/plans/2026-03-12-long-task-harness-packaging.md`
- Modify: repository root contents after import

- [ ] **Step 1: Verify the target directory is still empty apart from planning docs**

Run: `find . -maxdepth 2 -mindepth 1 -print | sort`
Expected: only planning docs and directories created for this work

- [ ] **Step 2: Import the packaged `long-task-dev` skeleton**

Run: `rsync -a --exclude '.git' ~/.claude/plugins/marketplaces/long-task-dev/ ./`
Expected: packaged repo skeleton appears in the target directory

- [ ] **Step 3: Verify the imported baseline**

Run: `find . -maxdepth 2 -mindepth 1 -print | sort | sed -n '1,200p'`
Expected: `skills/`, `commands/`, `scripts/`, `hooks/`, `.claude-plugin/`, `.opencode/`, `docs/`, `tests/`, install scripts, and README files exist

## Chunk 2: Refresh Skill Content And Local References

### Task 2: Overlay latest long-task skills from authoritative local sources

**Files:**
- Modify: `skills/using-long-task/SKILL.md`
- Modify: `skills/long-task-requirements/SKILL.md`
- Modify: `skills/long-task-ucd/SKILL.md`
- Modify: `skills/long-task-design/SKILL.md`
- Modify: `skills/long-task-init/SKILL.md`
- Modify: `skills/long-task-work/SKILL.md`
- Modify: `skills/long-task-tdd/SKILL.md`
- Modify: `skills/long-task-quality/SKILL.md`
- Modify: `skills/long-task-feature-st/SKILL.md`
- Modify: `skills/long-task-review/SKILL.md`
- Modify: `skills/long-task-st/SKILL.md`
- Modify: `skills/long-task-increment/SKILL.md`
- Modify: any required references under `skills/**`

- [ ] **Step 1: Overlay the latest long-task skill directories**

Run: `for dir in using-long-task long-task-requirements long-task-ucd long-task-design long-task-init long-task-work long-task-tdd long-task-quality long-task-feature-st long-task-review long-task-st long-task-increment; do rsync -a ~/.codex/skills/$dir/ skills/$dir/; done`
Expected: packaged skills now match the current local long-task versions

- [ ] **Step 2: Search for broken or externalized references**

Run: `rg -n "superpowers|~/.codex|~/.claude|suriyel|longtaskforagent|obra/superpowers" skills commands docs scripts hooks README.md README_EN.md CLAUDE.md`
Expected: all remaining matches are intentional and ready for cleanup

- [ ] **Step 3: Localize required references if any imported skills still assume external shared content**

Run: `rg -n "references/|prompts/" skills`
Expected: referenced files exist inside this repository or are updated accordingly

## Chunk 3: Normalize Product Identity And Install Paths

### Task 3: Update repository metadata and platform docs

**Files:**
- Modify: `README.md`
- Modify: `README_EN.md`
- Modify: `docs/README.opencode.md`
- Modify: `docs/README.codex.md`
- Create: `.codex/INSTALL.md`
- Modify: `.claude-plugin/plugin.json`
- Modify: `.claude-plugin/marketplace.json`
- Modify: `install.sh`
- Modify: `install.ps1`

- [ ] **Step 1: Update repo URL and identity references**

Run: `rg -n "suriyel|longtaskforagent|long-task-dev|long-task-agent" .`
Expected: all stale product/repo identifiers are located for replacement

- [ ] **Step 2: Edit metadata and docs to match `benwuhua/long-task-harness-skill`**

Expected changes:
- Claude marketplace source points at the new repo identity
- OpenCode install scripts clone the new repo URL
- Codex docs and install instructions point at the packaged `skills/` layout
- User-facing product name remains `long-task`

- [ ] **Step 3: Add Codex raw install entrypoint**

Run: `test -f .codex/INSTALL.md`
Expected: `.codex/INSTALL.md` exists with standalone install/update instructions

## Chunk 4: Clean Packaging Drift And Verify Executables

### Task 4: Validate paths, imports, and installer expectations

**Files:**
- Modify: `.opencode/plugins/long-task.js`
- Modify: `hooks/*`
- Modify: `CLAUDE.md`
- Modify: any scripts or docs still carrying stale path assumptions

- [ ] **Step 1: Search for consumer-facing path assumptions that no longer match**

Run: `rg -n "long-task-agent|long-task-harness-skill|\\.config/opencode|\\.agents/skills|\\.claude/plugins" .`
Expected: remaining paths are coherent and intentional

- [ ] **Step 2: Ensure OpenCode plugin resolves packaged skills correctly**

Run: `sed -n '1,240p' .opencode/plugins/long-task.js`
Expected: plugin root and `skills/` path assumptions align with the packaged repo

- [ ] **Step 3: Ensure Claude-facing docs and hook notes still match the packaged layout**

Run: `sed -n '1,260p' CLAUDE.md`
Expected: path notes and commands reflect this repository rather than an old upstream

## Chunk 5: Run Verification And Prepare Git Publishing

### Task 5: Execute tests and finalize git state

**Files:**
- Modify: any files needed to fix verification failures

- [ ] **Step 1: Run the Python test suite**

Run: `python3 -m pytest tests -q`
Expected: all tests pass

- [ ] **Step 2: Run a final repo-wide identity and dependency audit**

Run: `rg -n "suriyel|longtaskforagent|obra/superpowers|~/.codex|~/.claude/plugins/marketplaces/long-task-dev" .`
Expected: no stale shipping references remain, or only clearly intentional documentation mentions remain

- [ ] **Step 3: Initialize git history if needed**

Run: `git status --short --branch`
Expected: repository is under git and ready for commit

- [ ] **Step 4: Commit the packaged repository**

Run:
```bash
git add .
git commit -m "feat: package long-task harness for claude, opencode, and codex"
```
Expected: commit succeeds with the standalone packaging state

- [ ] **Step 5: Add GitHub remote and push**

Run:
```bash
git remote add origin git@github.com:benwuhua/long-task-harness-skill.git
git push -u origin main
```
Expected: repository is published to GitHub
