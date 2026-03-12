# Harness Surface Visibility Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the repository visibly harness-first by adding repo-surface docs, templates, and structure markers.

**Architecture:** Add one packaging-level test that defines the expected surface assets, then implement the minimal documentation and directory structure required to make that test pass. Keep the change documentation-first and avoid adding runtime dependencies or heavyweight demo content.

**Tech Stack:** Markdown, Python tests, repository packaging docs

---

## Chunk 1: Lock Expected Surface Assets With A Failing Test

### Task 1: Add packaging-level harness surface assertions

**Files:**
- Create: `tests/test_harness_surface.py`

- [ ] **Step 1: Write the failing test**

Add assertions for:
- `README.md` mentions `Harness Engineering`
- `README_EN.md` mentions `Harness Engineering`
- `docs/HARNESS_ENGINEERING.md` exists
- all four new template files exist
- `docs/runbooks/README.md` exists
- `artifacts/README.md` exists

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 tests/test_harness_surface.py`
Expected: FAIL because the repository does not yet expose the required assets

## Chunk 2: Add The Visible Harness Assets

### Task 2: Surface harness engineering at the repository level

**Files:**
- Modify: `README.md`
- Modify: `README_EN.md`
- Create: `docs/HARNESS_ENGINEERING.md`
- Create: `docs/templates/env-guide-template.md`
- Create: `docs/templates/long-task-guide-template.md`
- Create: `docs/templates/runbook-template.md`
- Create: `docs/templates/artifacts-readme-template.md`
- Create: `docs/runbooks/README.md`
- Create: `artifacts/README.md`

- [ ] **Step 1: Update both README files**

Add a dedicated harness section that points readers at the new docs and template set.

- [ ] **Step 2: Add the dedicated harness document**

Write `docs/HARNESS_ENGINEERING.md` with the repository-facing explanation of harness-first engineering.

- [ ] **Step 3: Add the four templates**

Each template should include concrete starter sections rather than placeholder headings only.

- [ ] **Step 4: Add the visible runbook and artifact landing files**

Create the `docs/runbooks/` and `artifacts/` readmes so the structure is visible immediately.

## Chunk 3: Verify And Publish

### Task 3: Re-run tests and finalize git state

**Files:**
- Modify: any touched file if verification exposes gaps

- [ ] **Step 1: Run the new harness surface test**

Run: `python3 tests/test_harness_surface.py`
Expected: PASS

- [ ] **Step 2: Run the repository regression suite**

Run a repo-wide Python test sweep using the existing local harness.
Expected: all existing tests still pass

- [ ] **Step 3: Commit and push**

Run:
```bash
git add README.md README_EN.md docs/HARNESS_ENGINEERING.md docs/templates docs/runbooks artifacts tests docs/superpowers
git commit -m "docs: surface harness engineering assets"
git push
```
Expected: repository includes the new harness-first surface assets
