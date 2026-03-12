# Harness Engineering

The repository is the harness. If an agent needs oral context, Slack notes, dashboards, or a specific human to continue, the harness is incomplete.

## What This Means In Practice

Harness engineering makes repo-local assets part of the product:

- startup, shutdown, reset, and health-check commands live in versioned docs
- worker workflow is written down in a repo-local guide
- recurring failures get diagnosis and recovery runbooks
- logs, screenshots, traces, and reports land in predictable artifact paths

The goal is not more documentation. The goal is to remove hidden state and make work reproducible.

## Signals That The Harness Is Incomplete

| Symptom | Required response |
| --- | --- |
| The same blocker appears twice | Add or fix a repo-local harness asset before continuing feature work |
| Humans keep checking dashboards manually | Add a command, script, artifact export, or local report path |
| Review keeps catching the same workflow mistake | Add a mechanical guardrail or make the workflow explicit in repo docs |
| A failure cannot be localized quickly | Improve logs, health checks, reset flows, or evidence capture |
| A worker depends on tribal knowledge | Move that knowledge into a template, guide, or runbook |

## Preferred Harness Assets

The long-task harness favors a small set of repo-visible assets:

- `env-guide.md` for start, stop, reset, seed, and health-check commands
- `long-task-guide.md` for the worker-facing workflow and mandatory gates
- `docs/runbooks/*.md` for diagnosis and recovery procedures
- `artifacts/` for logs, screenshots, traces, captured responses, and reports
- deterministic scripts such as `scripts/diagnose-*`, `scripts/reset-*`, and `scripts/smoke-*`

The templates for these assets live in [`docs/templates/`](templates/).

## Surface Assets In This Repository

This repository makes the harness visible by default:

- [`docs/templates/env-guide-template.md`](templates/env-guide-template.md)
- [`docs/templates/long-task-guide-template.md`](templates/long-task-guide-template.md)
- [`docs/templates/runbook-template.md`](templates/runbook-template.md)
- [`docs/templates/artifacts-readme-template.md`](templates/artifacts-readme-template.md)
- [`docs/runbooks/README.md`](runbooks/README.md)
- [`artifacts/README.md`](../artifacts/README.md)

These are meant to be copied and adapted into real projects, not treated as decorative docs.

## Maintenance Rules

1. Prefer repo-local commands over oral instructions.
2. Prefer deterministic reset and smoke-test flows over manual setup.
3. Prefer mechanical enforcement over repeated review comments.
4. When a bug or feature exposes a missing harness asset, update that asset in the same change.
5. Remove or fix stale harness docs immediately. A partially correct harness is worse than none.
