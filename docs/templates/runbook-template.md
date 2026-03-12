# Runbook Template

Use this template for `docs/runbooks/<issue-name>.md`. Each runbook should help a worker move from symptom to diagnosis to recovery.

## Summary

Describe the failure mode in one sentence.

## Trigger Signals

- Error messages
- Failed health checks
- Broken routes or endpoints
- Missing artifacts or empty reports

## Fast Triage

List the first 2-3 commands or checks to run.

```bash
# Check process health

# Reproduce the failing operation

# Inspect the latest artifact bundle
```

## Diagnosis

Explain how to separate likely causes.

| Signal | Likely cause | Next check |
| --- | --- | --- |
| Startup succeeds, requests fail | Dependency not reachable | Check service health and local config |
| Tests hang | Background process or fixture leak | Run reset flow and inspect logs |

## Recovery

Document the exact commands to restore service.

```bash
# Reset state

# Restart services

# Re-run smoke test
```

## Evidence To Capture

- Relevant log paths
- Screenshot paths
- Trace or network capture paths
- Output files to attach to the task or issue

## Escalation Rule

State when a worker should stop and open a new issue instead of retrying manually.
