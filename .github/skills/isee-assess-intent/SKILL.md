---
name: isee-assess-intent
description: Assess the Intent layer — scan for explicit intent statements, outcome definitions, and decision criteria.
user-invocable: false
---

# Assess Intent Layer

Evaluate how well the team's intent is expressed — clearly enough for both people and agents to act on.

## What to scan

Read these files (if they exist):

1. **Copilot instructions**: `.github/copilot-instructions.md` — look for intent statements, priorities, values, outcome definitions
2. **README**: `README.md` — look for project goals, purpose, outcome-oriented descriptions
3. **Contributing guide**: `CONTRIBUTING.md` — look for decision criteria, what constitutes "done"
4. **Agent definitions**: `.github/agents/*.agent.md` — look for embedded intent, constraints, operating rules
5. **Docs directory**: `docs/` — scan for strategy documents, architecture decision records (ADRs), team charters
6. **ISEE docs**: `.github/isee/` or `docs/isee/` — dedicated ISEE documentation if it exists
7. **PR templates**: `.github/pull_request_template.md` — does it ask for intent/outcome?
8. **Issue templates**: `.github/ISSUE_TEMPLATE/` — do they require outcome/goal statements?

## What to look for

### Intent signals (PRESENT)
- Explicit outcome statements ("This project aims to reduce deployment time by 50%")
- Priority declarations ("reliability > feature velocity")
- Decision criteria ("PRs must demonstrate user impact")
- Values or principles that guide trade-offs
- Agent-readable intent (clear enough for an AI to act on without guessing)

### Intent gaps (ABSENT)
- Project purpose described only in terms of what it IS, not what it ACHIEVES
- No explicit priorities or trade-off guidance
- Ambiguous language that could be interpreted multiple ways
- Intent trapped in tribal knowledge (nothing written down)
- No distinction between "must have" and "nice to have"

### Intent questions (UNKNOWN)
When signals are weak, ask the user:

```
Use ask_user:
  message: "I found limited explicit intent in your repo. A few quick questions to understand your team's intent layer:"
  requestedSchema:
    properties:
      priorities:
        type: string
        title: "What are your team's top 2-3 priorities right now?"
        description: "e.g., reliability, shipping speed, cost reduction, security posture"
      outcomes:
        type: string
        title: "How does your team define 'done' for a feature or project?"
      where_intent_lives:
        type: string
        title: "Where does your team document goals and priorities?"
        description: "e.g., README, Confluence, Notion, Jira epics, team meetings, nowhere specific"
    required: [priorities]
```

## Scoring

Apply the rubric from the agent definition. For each signal found or missing, record:
- Signal, State (Present/Absent/Unknown), Confidence (High/Medium/Low), Citation, Impact, Recommendation

### Profile-adjusted expectations
- **Lightweight**: Intent in README is sufficient. 2-3 explicit statements = strong.
- **Standard**: Dedicated docs or copilot-instructions section. 5+ explicit statements across intent, priorities, trade-offs.
- **Regulated**: Approved strategy docs, ADRs, compliance-linked outcome definitions. Traceability from intent to implementation.

## Output

Produce a structured summary:

```
## Intent Layer Assessment

### Findings
[List each finding with the rubric format]

### Summary
- Signals found: X present, Y absent, Z unknown
- Confidence: [overall confidence level]
- Key strength: [what's working well]
- Key gap: [most impactful missing signal]
- Top recommendation: [single most valuable next step]
```

## SQL Update

```sql
UPDATE todos SET status = 'done' WHERE id = 'assess-intent';
```
