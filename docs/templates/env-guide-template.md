# Environment Guide Template

Use this file as `env-guide.md` in a long-task project. The goal is to make environment recovery deterministic for any worker.

## Purpose

Describe what this environment supports, which services it starts, and which parts are optional.

## Prerequisites

- Required language/runtime versions
- Required package managers or system dependencies
- Required credentials or local config files

## Start Commands

Document the exact commands for local startup.

```bash
# Install dependencies

# Start app or services

# Start supporting infrastructure
```

## Stop Commands

Document how to stop every long-running process cleanly.

```bash
# Stop app

# Stop supporting infrastructure
```

## Reset Commands

Document how to return the project to a known-good state.

```bash
# Clear caches or build output

# Reset local database or fixtures

# Recreate generated assets
```

## Health Checks

List the commands that prove the environment is ready.

```bash
# Example: API health

# Example: database connectivity

# Example: frontend smoke route
```

## Seed Data

Explain how to create the minimum useful dataset for local development and testing.

## Common Failure Modes

| Symptom | Likely cause | Recovery |
| --- | --- | --- |
| App boots but requests fail | Missing dependency | Re-run dependency install and health checks |
| Tests fail before execution | Config not loaded | Verify required config files and environment variables |

## Owner Notes

Capture any local assumptions that would otherwise live in oral context.
