# Runbook Index Scaffold Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `init_project.py` scaffold a visible runbook index without generating fake project-specific runbooks.

**Architecture:** Extend the deterministic initializer scaffold with `docs/runbooks/INDEX.md` and `docs/runbooks/TOPICS.md`, then lock the behavior with failing tests in `tests/test_init_project.py`. Keep all new files generic and purpose-only so the scaffold remains truthful.

**Tech Stack:** Python, Markdown, repository scaffold tests

---

## Chunk 1: Lock The Runbook Index Contract

### Task 1: Add failing tests for runbook index files

**Files:**
- Modify: `tests/test_init_project.py`
- Test: `tests/test_init_project.py`

- [ ] **Step 1: Write the failing test**

Add assertions that a fresh `run_init("test-project", tmp)` creates:
- `docs/runbooks/INDEX.md`
- `docs/runbooks/TOPICS.md`

Also assert:
- `INDEX.md` mentions indexing or listing concrete runbooks
- `TOPICS.md` mentions the suggested themes such as startup, diagnosis, recovery, dependency outage, and reproduction

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 tests/test_init_project.py`
Expected: FAIL because the initializer does not yet scaffold the runbook index files

## Chunk 2: Extend The Deterministic Scaffold

### Task 2: Generate runbook index files

**Files:**
- Modify: `skills/long-task-init/scripts/init_project.py`
- Modify: `skills/long-task-init/SKILL.md`

- [ ] **Step 1: Add content generators for `INDEX.md` and `TOPICS.md`**

The content should explain purpose only and avoid pretending the runbooks are already implemented.

- [ ] **Step 2: Create the files during scaffold generation**

Ensure `docs/runbooks/README.md`, `INDEX.md`, and `TOPICS.md` are all written on init.

- [ ] **Step 3: Update initializer-facing messaging**

Mention the runbook index files in:
- the deterministic scaffold description in `long-task-init/SKILL.md`
- the closing output in `init_project.py`

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
git commit -m "feat: scaffold runbook index markers"
git push
```
Expected: the initializer now produces a visible runbook index without fake runbooks
