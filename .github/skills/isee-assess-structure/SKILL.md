---
name: isee-assess-structure
description: Assess the Structure layer — check for codified constraints, guardrails, tool scoping, and trade-offs.
user-invocable: false
---

# Assess Structure Layer

Evaluate how well the team's constraints, guardrails, and trade-offs are codified — embedded in the environment so both people and agents follow them by default.

## What to scan

Read these files (if they exist):

1. **MCP config**: `.mcp.json` — tool scoping (read-only vs read+write), server boundaries
2. **CI/CD pipelines**: `.github/workflows/*.yml`, `azure-pipelines.yml`, `Jenkinsfile` — automated gates, required checks, deployment approvals
3. **Branch protection**: Check for required reviews, status checks, branch rules (ask user if not visible from repo)
4. **Security policies**: `SECURITY.md`, `.github/dependabot.yml`, CodeQL config, secret scanning
5. **Copilot instructions**: `.github/copilot-instructions.md` — constraint sections, "do not" rules, guardrails
6. **Infrastructure config**: `Dockerfile`, Terraform/Bicep files, Kubernetes manifests — cost limits, resource boundaries, scaling constraints
7. **Linting/formatting**: `.eslintrc`, `.prettierrc`, `tsconfig.json` (strict mode), `Cargo.toml` (deny warnings) — codified quality standards
8. **Cost/resource limits**: Azure/AWS budget alerts, resource quotas, rate limiting config
9. **Package policies**: `.npmrc`, `package.json` (engines, overrides), lockfile presence

## What to look for

### Structure signals (PRESENT)
- Tool scoping in `.mcp.json` (not just `"tools": ["*"]` everywhere)
- CI checks that enforce quality gates (tests, coverage thresholds, linting)
- Required PR reviews or approval gates
- Security scanning in CI pipeline
- Explicit cost/resource boundaries in infrastructure config
- Dependency update policies (Dependabot, Renovate)
- Strict compiler/linter settings (treating warnings as errors)
- Agent guardrails in copilot-instructions.md ("do not merge", "do not deploy")

### Structure gaps (ABSENT)
- `.mcp.json` with all servers at `"tools": ["*"]` (no scoping)
- No CI checks or only trivial checks (build-only, no quality gates)
- No branch protection
- No security scanning configured
- Infrastructure with no resource limits
- No linting or formatting enforcement
- Copilot instructions with no constraint section
- No dependency management policy

### Structure questions (UNKNOWN)
When signals are ambiguous or external:

```
Use ask_user:
  message: "Some structure signals may live outside the repo. A few questions:"
  requestedSchema:
    properties:
      branch_protection:
        type: string
        title: "Do you have branch protection rules enabled?"
        enum: ["Yes — required reviews + status checks", "Yes — basic (reviews only)", "No", "Not sure"]
        default: "Not sure"
      security_scanning:
        type: string
        title: "Do you use security scanning tools?"
        enum: ["Yes — in CI pipeline", "Yes — external tool (Snyk, SonarCloud, etc.)", "No", "Not sure"]
        default: "Not sure"
      cost_guardrails:
        type: string
        title: "Do you have cost or resource limits in place?"
        enum: ["Yes — budget alerts / resource quotas", "Informal limits", "No", "Not applicable"]
        default: "Not sure"
    required: [branch_protection]
```

## Scoring

Apply the rubric. For each signal:
- Signal, State, Confidence, Citation, Impact, Recommendation

### Profile-adjusted expectations
- **Lightweight**: Basic CI checks + linting is sufficient. Informal constraints documented somewhere.
- **Standard**: CI with quality gates, branch protection, tool scoping, security scanning, documented constraints.
- **Regulated**: Policy-as-code, mandatory approval gates, audit-grade security scanning, cost controls, compliance-linked constraints.

## Output

```
## Structure Layer Assessment

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
UPDATE todos SET status = 'done' WHERE id = 'assess-structure';
```
