# Artifacts README Template

Use this file as `artifacts/README.md` in a project. It defines where evidence goes and how workers should name it.

## Purpose

`artifacts/` stores durable evidence for debugging, testing, and review. If evidence matters to a decision, it should land here instead of disappearing in terminal scrollback.

## Suggested Layout

```text
artifacts/
  logs/
  screenshots/
  traces/
  reports/
  reproductions/
```

## Naming Conventions

- Include date or timestamp when evidence is time-sensitive
- Include feature ID or issue ID when evidence is tied to a work item
- Prefer short, descriptive names over generic `output.txt`

## What To Store

- failing and passing test reports
- screenshots or videos from UI acceptance checks
- network captures or traces used in diagnosis
- command output that supports a status transition

## What Not To Store

- secrets
- machine-specific junk that cannot help future diagnosis
- large generated artifacts with no known consumer

## Retention

Define which artifacts should be kept, rotated, or deleted after a release.
