# Artifact Layout Scaffold Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `init_project.py` scaffold a standard evidence layout under `artifacts/` with per-directory README placeholders.

**Architecture:** Extend the deterministic initializer scaffold with five artifact subdirectories and minimal purpose-only README markers. Lock the behavior with failing tests in `tests/test_init_project.py`, then implement the smallest generator changes needed to satisfy them while keeping the scaffold generic.

**Tech Stack:** Python, Markdown, repository scaffold tests

---

## Chunk 1: Lock The Artifact Layout Contract

### Task 1: Add failing tests for artifact subdirectory scaffolding

**Files:**
- Modify: `tests/test_init_project.py`
- Test: `tests/test_init_project.py`

- [ ] **Step 1: Write the failing test**

Add assertions that a fresh `run_init("test-project", tmp)` creates:
- `artifacts/logs/README.md`
- `artifacts/reports/README.md`
- `artifacts/screenshots/README.md`
- `artifacts/traces/README.md`
- `artifacts/reproductions/README.md`

Also assert each placeholder mentions its intended evidence type.

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 tests/test_init_project.py`
Expected: FAIL because the initializer does not yet scaffold the artifact subdirectory layout

## Chunk 2: Extend The Deterministic Scaffold

### Task 2: Generate artifact subdirectories and README markers

**Files:**
- Modify: `skills/long-task-init/scripts/init_project.py`
- Modify: `skills/long-task-init/SKILL.md`

- [ ] **Step 1: Add content generators for the five artifact subdirectory README files**

Each generator should be short and explain purpose only.

- [ ] **Step 2: Create the five subdirectories and README markers during scaffold generation**

Ensure the generated root `artifacts/README.md` also reflects the standard layout.

- [ ] **Step 3: Update initializer-facing messaging**

Mention the standard evidence layout in:
- `init_project.py` closing output
- `long-task-init/SKILL.md` deterministic scaffold description

## Chunk 3: Verify And Finalize

### Task 3: Run targeted and full regression verification

**Files:**
- Modify: touched files only if verification exposes gaps

- [ ] **Step 1: Run the targeted initializer suite**

Run: `python3 tests/test_init_project.py`
Expected: PASS

- [ ] **Step 2: Run the full repository Python test sweep**

Run: `for f in tests/test_*.py; do python3 "$f" || exit 1; done`
Expected: all test files pass

- [ ] **Step 3: Commit and push**

Run:
```bash
git add skills/long-task-init/SKILL.md skills/long-task-init/scripts/init_project.py tests/test_init_project.py docs/superpowers
git commit -m "feat: scaffold artifact evidence layout"
git push
```
Expected: the initializer now produces a visible, self-describing evidence layout
