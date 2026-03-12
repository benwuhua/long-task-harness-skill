# Init Harness Scaffold Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `init_project.py` scaffold visible harness structure by creating runbook and artifact placeholder directories plus README markers.

**Architecture:** Extend the deterministic initializer scaffold with two always-safe structure markers: `docs/runbooks/README.md` and `artifacts/README.md`. Lock the behavior with new failing tests in `tests/test_init_project.py`, then implement the smallest generator changes needed to make those tests pass without creating misleading project-specific docs.

**Tech Stack:** Python, Markdown, repository scaffold tests

---

## Chunk 1: Lock The New Scaffold Contract

### Task 1: Add failing initializer tests for harness structure markers

**Files:**
- Modify: `tests/test_init_project.py`
- Test: `tests/test_init_project.py`

- [ ] **Step 1: Write the failing test**

Add tests asserting that a fresh `run_init("test-project", tmp)` creates:
- `docs/runbooks/README.md`
- `artifacts/README.md`

Also assert the placeholder text is purpose-only:
- runbooks README mentions diagnosis or recovery
- artifacts README mentions logs, screenshots, traces, or reports

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 tests/test_init_project.py`
Expected: FAIL because the initializer does not yet create the new harness markers

## Chunk 2: Extend The Deterministic Scaffold

### Task 2: Generate the harness directory markers

**Files:**
- Modify: `skills/long-task-init/scripts/init_project.py`

- [ ] **Step 1: Add helper content generators**

Create short deterministic string builders for:
- `docs/runbooks/README.md`
- `artifacts/README.md`

The content should explain purpose only and avoid project-specific commands.

- [ ] **Step 2: Create the new directories and files**

During scaffold generation, ensure:
- `docs/runbooks/` exists
- `artifacts/` exists
- their `README.md` files are written

- [ ] **Step 3: Keep existing scaffold behavior intact**

Do not change the existing contract around:
- `long-task-guide.md`
- `init.sh` / `init.ps1`
- `feature-list.json`
- `CLAUDE.md` / `AGENTS.md`
- `task-progress.md`

## Chunk 3: Verify And Finalize

### Task 3: Run targeted and full regression verification

**Files:**
- Modify: touched files only if verification exposes a defect

- [ ] **Step 1: Run the targeted initializer suite**

Run: `python3 tests/test_init_project.py`
Expected: PASS

- [ ] **Step 2: Run the full repository Python test sweep**

Run: `for f in tests/test_*.py; do python3 "$f" || exit 1; done`
Expected: all test files pass

- [ ] **Step 3: Commit and push**

Run:
```bash
git add skills/long-task-init/scripts/init_project.py tests/test_init_project.py docs/superpowers
git commit -m "feat: scaffold harness structure markers"
git push
```
Expected: the initializer now produces visible harness structure markers in fresh projects
