# Long-Task Guide Template

Use this file as `long-task-guide.md` in a long-task project. It is the worker-facing operating manual for a single session.

## Session Workflow

### Step 1: Orient

- Read `task-progress.md`
- Read `feature-list.json`
- Confirm the next failing or pending feature to work on

### Step 2: Restore The Harness

- Read `env-guide.md`
- Run startup and health-check commands
- Confirm required configs are present

### Step 3: TDD Red

- Write the failing test first
- Verify the failure is caused by the missing behavior

### Step 4: TDD Green

- Implement the smallest change that makes the failing test pass
- Re-run the targeted test

### Step 5: Refactor

- Clean up names, duplication, and boundaries
- Keep the test suite green

### Step 6: Quality Gates

- Run coverage checks
- Run mutation checks if configured
- Capture fresh evidence before changing feature status

### Step 7: Persist State

- Update `task-progress.md`
- Update feature status in `feature-list.json`
- Commit the completed slice

## Required Commands

List the exact commands workers should run for:

- unit tests
- coverage
- mutation testing
- smoke testing
- black-box checks

## Critical Rules

- Never write implementation before a failing test
- Never mark a feature as passing without fresh evidence
- Never rely on oral context when the repo can hold the same knowledge
- Add or repair harness assets when recurring friction appears
