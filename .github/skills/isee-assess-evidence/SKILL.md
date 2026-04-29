---
name: isee-assess-evidence
description: Assess the Evidence layer — check for feedback loops, monitoring, CI reporting, and upstream signal flow.
user-invocable: false
---

# Assess Evidence Layer

Evaluate whether the team produces observable signals that flow back upstream — feedback that actually changes the next decision.

## What to scan

Read these files (if they exist):

1. **CI/CD pipelines**: `.github/workflows/*.yml` — test reporting, coverage uploads, status checks, deployment notifications
2. **Monitoring config**: References to monitoring tools in code, config, or docs (Datadog, Grafana, App Insights, CloudWatch)
3. **Alerting**: Alert definitions in infrastructure files, PagerDuty/OpsGenie config references
4. **Test setup**: Test configuration files, coverage thresholds, test reporting formats
5. **Copilot instructions**: `.github/copilot-instructions.md` — evidence/reporting sections, "after deploying, verify" patterns
6. **MCP servers**: `.mcp.json` — monitoring/observability servers configured (datadog-mcp-server, etc.)
7. **Status badges**: `README.md` — CI status badges, coverage badges, health indicators
8. **Release/changelog**: `CHANGELOG.md`, release workflow — does the team produce evidence of what shipped?
9. **Error tracking**: References to Sentry, Bugsnag, Application Insights in config or dependencies

## What to look for

### Evidence signals (PRESENT)
- CI pipeline that reports test results (not just pass/fail)
- Coverage thresholds enforced in CI
- Monitoring/alerting configured and referenced in docs
- Status badges in README (public evidence of system health)
- Deployment verification steps in CI/CD (smoke tests, health checks after deploy)
- Changelog or release notes that document what shipped and why
- MCP servers for monitoring tools (agents can query observability data)
- Error tracking integrated (errors flow upstream automatically)
- Agent instructions that include "verify after action" patterns

### Evidence gaps (ABSENT)
- CI runs tests but doesn't report results or coverage
- No monitoring references anywhere in the repo
- No alerting configuration
- Deployments with no verification step
- No changelog or release documentation
- No status badges or health indicators
- Agents with no "check your work" guidance
- Feedback that stays in dashboards but doesn't flow to decisions

### Evidence questions (UNKNOWN)
Much of evidence lives outside the repo:

```
Use ask_user:
  message: "Evidence signals often live in external tools. A few questions:"
  requestedSchema:
    properties:
      monitoring:
        type: string
        title: "What monitoring/observability tools does your team use?"
        enum:
          - "Datadog / Grafana / Prometheus"
          - "Azure Monitor / App Insights"
          - "AWS CloudWatch"
          - "Basic (just CI status)"
          - "None"
          - "Other"
        default: "Basic (just CI status)"
      alerting:
        type: string
        title: "How are you alerted when something goes wrong?"
        enum:
          - "Automated alerts (PagerDuty, OpsGenie, etc.)"
          - "CI failure notifications"
          - "Manual checking"
          - "We find out from users"
        default: "CI failure notifications"
      feedback_to_decisions:
        type: string
        title: "Does production feedback change your next decisions?"
        description: "e.g., post-incident reviews lead to backlog items, metrics drive priorities"
        enum:
          - "Yes — structured process (retros, post-mortems → action items)"
          - "Sometimes — ad hoc"
          - "Rarely — we react but don't systematically learn"
        default: "Sometimes — ad hoc"
    required: [monitoring]
```

## Scoring

Apply the rubric. For each signal:
- Signal, State, Confidence, Citation, Impact, Recommendation

### Profile-adjusted expectations
- **Lightweight**: CI reporting tests pass/fail + basic error tracking is sufficient. Feedback loop can be informal.
- **Standard**: Coverage thresholds, monitoring, alerting, deployment verification, changelog. Feedback flows to backlog.
- **Regulated**: Audit-grade evidence trails, mandatory post-incident reviews, compliance reporting, SLA monitoring, change evidence.

## Output

```
## Evidence Layer Assessment

### Findings
[List each finding with rubric format]

### Summary
- Signals found: X present, Y absent, Z unknown
- Confidence: [overall confidence level]
- Key strength: [what's working well]
- Key gap: [most impactful missing signal]
- Top recommendation: [single most valuable next step]
```

## SQL Update

```sql
UPDATE todos SET status = 'done' WHERE id = 'assess-evidence';
```
