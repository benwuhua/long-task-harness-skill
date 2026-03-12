# Init Harness Messaging Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Clarify `long-task-init` messaging so users can distinguish the deterministic harness scaffold from later generated project-specific docs.

**Architecture:** Lock the expected messaging in initializer tests first, then update `long-task-init/SKILL.md` and `init_project.py` output with minimal two-layer wording. Keep the change documentation-focused and aligned with the current scaffold behavior.

**Tech Stack:** Markdown, Python tests

---

## Chunk 1: Lock The Expected Messaging

### Task 1: Add failing tests for initializer output messaging

**Files:**
- Modify: `tests/test_init_project.py`
- Test: `tests/test_init_project.py`

- [ ] **Step 1: Write the failing test**

Add assertions that `run_init("test-project", tmp)` stdout mentions:
- deterministic scaffold
- runbooks and artifacts structure markers
- `env-guide.md` as a later generated doc

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 tests/test_init_project.py`
Expected: FAIL because current output does not explain the two-layer model clearly enough

## Chunk 2: Update Skill And Initializer Messaging

### Task 2: Clarify scaffold-vs-generated boundaries

**Files:**
- Modify: `skills/long-task-init/SKILL.md`
- Modify: `skills/long-task-init/scripts/init_project.py`

- [ ] **Step 1: Update the skill document**

Revise Step 2 so it includes the new harness markers and explains that they are deterministic placeholders rather than complete operational docs.

- [ ] **Step 2: Update initializer stdout**

Split the closing summary into:
- deterministic scaffold created
- later docs still to generate

Include `env-guide.md` in the latter group.

## Chunk 3: Verify And Finalize

### Task 3: Re-run tests and publish

**Files:**
- Modify: touched files only if verification exposes a problem

- [ ] **Step 1: Run the targeted initializer suite**

Run: `python3 tests/test_init_project.py`
Expected: PASS

- [ ] **Step 2: Run the full repository Python test sweep**

Run: `for f in tests/test_*.py; do python3 "$f" || exit 1; done`
Expected: all tests pass

- [ ] **Step 3: Commit and push**

Run:
```bash
git add skills/long-task-init/SKILL.md skills/long-task-init/scripts/init_project.py tests/test_init_project.py docs/superpowers
git commit -m "docs: clarify init harness scaffold messaging"
git push
```
Expected: initializer messaging clearly explains the harness scaffold boundary
