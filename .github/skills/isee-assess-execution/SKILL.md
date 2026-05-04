---
name: isee-assess-execution
description: Assess the Execution layer — evaluate team topology, context distribution, and coordination patterns.
user-invocable: false
---

# Assess Execution Layer

Evaluate how the team ships — whether coordination is distributed through artifacts and context, or trapped in handoffs and meetings.

## What to scan

Read these files (if they exist):

1. **CODEOWNERS**: `CODEOWNERS` or `.github/CODEOWNERS` — ownership boundaries, team structure
2. **Team docs**: `docs/team/`, `docs/architecture/`, `ARCHITECTURE.md` — team topology, service ownership
3. **PR templates**: `.github/pull_request_template.md` — does it carry context (intent, trade-offs, what changed and why)?
4. **Agent definitions**: `.github/agents/*.agent.md` — are agents operating as autonomous cells with clear scope?
5. **Skills**: `.github/skills/*/SKILL.md` — are skills scoped to specific responsibilities?
6. **Copilot instructions**: `.github/copilot-instructions.md` — workflow sections, cross-tool chains, execution guidance
7. **Git history**: Recent commit messages and PR titles — do they carry context or just describe what changed?
8. **Monorepo indicators**: workspace configs, multiple package.json files, service directories — team boundaries visible in code structure?

## What to look for

### Execution signals (PRESENT)
- CODEOWNERS with clear ownership boundaries (not just `* @team`)
- PR template that asks for context: "What problem does this solve?", "What trade-offs were made?"
- Commit messages that carry intent, not just changes ("Fix auth timeout to meet SLA" vs "Fix bug")
- Agent definitions with scoped responsibilities
- Cross-tool workflows documented in copilot-instructions.md
- Service/module boundaries visible in repo structure
- ADRs (Architecture Decision Records) that distribute decision context

### Upstream context connections (Execution)

Scan for references that link execution patterns to external coordination:

**Direct connections** (discoverable in-repo):
- Work item references in commit messages (scan git log for `AB#\d+`, `JIRA-\d+`, `#\d+`, `fixes`, `closes`, `resolves`)
- PR template fields that require work item links or upstream references
- Cross-repo ownership references in CODEOWNERS comments
- Agent definitions distributed via packaging systems — remote agent packaging is a form of distributed execution context. Look for package manifests or installed modules containing agent primitives from external sources.
- GitHub Projects or milestones referenced in issue templates

**Indirect connections** (referenced but external):
- Team names or external stakeholders mentioned in docs
- References to cross-team dependencies ("coordinated with platform team")
- External workflow tools mentioned (Jira boards, ADO sprints, Linear)
- Meeting or ritual references that suggest external coordination patterns

### Execution gaps (ABSENT)
- No CODEOWNERS or overly broad ownership
- PR template with only a checklist (no context fields)
- Commit messages that describe only mechanical changes
- No agent/skill definitions (no AI-native execution layer)
- No documented workflows or cross-tool chains
- Monolithic structure with no clear boundaries
- Decisions trapped in meeting notes or Slack (not in repo artifacts)
- No work item traceability — commits and PRs disconnected from upstream work tracking
- No cross-team context — execution appears isolated from organizational coordination

### Execution questions (UNKNOWN)
When repo signals are weak. **If the repo references external coordination (work item boards, team docs, etc.), attempt to follow those references using available tools. If unreachable, record that as a finding — don't ask the user to go retrieve the content.**

```
Use ask_user:
  message: "Execution patterns are harder to assess from repo alone. A few questions:"
  requestedSchema:
    properties:
      team_structure:
        type: string
        title: "How is your team organized?"
        enum:
          - "Small team — everyone owns everything"
          - "Service-oriented — teams own specific services/modules"
          - "Platform + product teams — shared infrastructure layer"
          - "Other"
        default: "Small team — everyone owns everything"
      coordination:
        type: string
        title: "How does your team coordinate work?"
        enum:
          - "Mostly through artifacts (PRs, docs, tickets)"
          - "Mix of artifacts and meetings"
          - "Mostly through meetings and Slack"
        default: "Mix of artifacts and meetings"
      agents_in_use:
        type: boolean
        title: "Are you using AI agents (Copilot, etc.) in your workflow?"
        default: true
    required: [team_structure]
```

## Scoring

Apply the rubric. For each signal:
- Signal, State, Confidence, Citation, Impact, Recommendation

### Profile-adjusted expectations
- **Lightweight**: Small teams don't need CODEOWNERS. PR descriptions carrying context is the key signal. Agent usage is a bonus. Work item refs optional.
- **Standard**: CODEOWNERS, context-rich PRs, documented workflows, some agent integration. Coordination through artifacts more than meetings. Work item traceability in commits/PRs expected.
- **Regulated**: Formal ownership model, decision audit trail (ADRs), policy-compliant workflows, agent boundaries documented. Full work item traceability and cross-team coordination evidence required.

## Output

```
## Execution Layer Assessment

### Findings
[List each finding with rubric format]

### Upstream Context Connections (Execution)
- **Direct**: [work item refs in commits/PRs, cross-repo ownership — with citations]
- **Indirect**: [team/stakeholder references, external workflow tools — with citations]
- **Work item traceability**: [Connected / Partial / None — can execution be traced to upstream work items?]

### Summary
- Signals found: X present, Y absent, Z unknown
- Confidence: [overall confidence level]
- Key strength: [what's working well]
- Key gap: [most impactful missing signal]
- Top recommendation: [single most valuable next step]
```

## SQL Update

```sql
UPDATE todos SET status = 'done' WHERE id = 'assess-execution';
```
