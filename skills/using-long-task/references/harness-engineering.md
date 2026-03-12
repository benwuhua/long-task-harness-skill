# Harness Engineering In Long-Task Projects

The repository is the harness. If an agent needs oral context, Slack notes, dashboards, or a specific human to continue, the harness is incomplete.

## Treat These As Harness Gaps

| Symptom | Required response |
|---|---|
| Same blocker appears twice | Stop feature work and add a repo-local harness asset before continuing |
| Humans keep checking dashboards manually | Add a script, command, runbook, or artifact bundle that exposes the same evidence locally |
| Review keeps catching the same boundary violation | Add a mechanical guardrail: lint rule, structural test, contract test, import boundary check |
| A failure cannot be localized quickly | Add clearer logs, trace IDs, screenshots, network capture, health checks, or reset/seed commands |
| A workflow depends on hidden state | Add deterministic reset, seed, and smoke-test commands |

## Preferred Harness Assets

- `env-guide.md` for start/stop/reset/health-check commands
- `long-task-guide.md` for the worker-facing workflow and direct commands
- `docs/runbooks/*.md` for diagnosis and recovery procedures
- `scripts/diagnose-*`, `scripts/reset-*`, `scripts/smoke-*` for repeatable workflows
- `artifacts/` with a documented structure for logs, screenshots, traces, and captured evidence
- Lint rules, import-boundary checks, contract tests, and smoke tests for rules that should fail mechanically

## Priority Order

1. Prefer mechanical enforcement over review comments.
2. Prefer repo-local commands over tribal knowledge.
3. Prefer deterministic reset/reproduce flows over manual setup.
4. Update the harness in the same commit as the feature or bugfix that proved the previous harness was stale.

## Entropy Rule

Stale harness is a defect. If a command, runbook, artifact path, or enforcement rule drifts from reality, fix or remove it immediately. A partially correct harness is often worse than none because later agents trust it.
