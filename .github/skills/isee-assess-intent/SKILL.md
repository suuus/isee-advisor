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

### Intent levels

Intent operates at multiple levels. Assess which levels are explicitly expressed and whether they form a traceable chain:

| Level | What it captures | Where to find it (Direct) | Indirect indicators |
|-------|-----------------|--------------------------|---------------------|
| **Organizational** | Mission, vision, why the team/org exists | README (mission section), `docs/strategy/`, `.github/isee/` | References to company OKRs, external strategy docs, org-level policy links |
| **Business** | Priorities, outcomes, trade-offs | `.github/copilot-instructions.md` (priorities section), ADRs | Linked Jira epics, GitHub Project descriptions, roadmap references |
| **Product** | What to build, for whom, success criteria | Issue templates (outcome fields), `docs/product/`, PR templates | Linked product specs, user story patterns, acceptance criteria in issues |
| **Architecture** | System constraints, quality attributes, boundaries | `ARCHITECTURE.md`, ADRs, `docs/architecture/` | Referenced architecture repos, C4 model links, API contract references |
| **Platform** | Runtime constraints, deployment model, toolchain decisions | Infrastructure config, CI/CD config, `.mcp.json`, linter configs | Referenced platform docs, shared infrastructure repos, platform team constraints |

For each level found, record:
- **State**: Present (explicit statement found) / Absent (level not addressed) / Unknown (may exist externally)
- **Source**: Direct (in-repo artifact) or Indirect (referenced but lives elsewhere)

Score intent levels on three dimensions:
- **Breadth** — How many of the 5 levels have explicit intent? (Lightweight: 2+ is strong. Standard: 3+. Regulated: 4+.)
- **Depth** — Can intent be traced from organizational → platform? Are lower-level choices justified by higher-level intent?
- **Coherence** — Do lower-level statements align with higher-level ones? Or do they contradict? (e.g., org says "reliability first" but platform config has no resource limits)

### Upstream context connections

Scan for references that link this repo's intent to external context:

**Direct connections** (discoverable in-repo or via available tools):
- GitHub Issues/Projects linked in docs or config
- Cross-repo references (`see also: org/other-repo`, `inherits from:`)
- `.github/isee/context.md` or similar dedicated upstream context doc
- Work item references in PR/issue templates (`fixes #`, `AB#`, Jira key patterns)

**Indirect connections** (referenced but requires following a link or asking):
- URLs to external docs (Confluence, Notion, wiki)
- References to organizational policies ("per security policy X", "as required by compliance team")
- Mentions of team names, stakeholders, or external owners
- Tool names suggesting external intent sources (Jira, ADO, ServiceNow, Aha!)

When upstream connections are found, note them. When absent, recommend:
- A `.github/isee/context.md` documenting where upstream intent lives
- Work item references in PR templates
- Cross-repo links in architecture docs

### Intent gaps (ABSENT)
- Project purpose described only in terms of what it IS, not what it ACHIEVES
- No explicit priorities or trade-off guidance
- Ambiguous language that could be interpreted multiple ways
- Intent trapped in tribal knowledge (nothing written down)
- No distinction between "must have" and "nice to have"
- Intent exists at only one level (e.g., product-only, no organizational or architectural intent)
- No traceable chain between intent levels
- No upstream context connections — intent appears to exist in isolation

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

### Intent level scoring
In addition to individual signals, score the intent levels:
- **Breadth**: X of 5 levels have explicit intent (list which)
- **Depth**: Traceable / Partially traceable / Fragmented (can lower levels be traced to higher?)
- **Coherence**: Aligned / Mixed / Contradictory (do levels reinforce or contradict each other?)

### Upstream context scoring
- **Direct connections found**: X (list each with citation)
- **Indirect connections found**: X (list each with citation)
- **Context isolation risk**: Low (many connections) / Medium (some connections) / High (intent appears isolated)

### Profile-adjusted expectations
- **Lightweight**: Intent in README is sufficient. 2-3 explicit statements = strong. 2+ intent levels sufficient. Upstream connections optional but noted.
- **Standard**: Dedicated docs or copilot-instructions section. 5+ explicit statements across intent, priorities, trade-offs. 3+ intent levels expected. At least some upstream connections.
- **Regulated**: Approved strategy docs, ADRs, compliance-linked outcome definitions. 4+ intent levels with traceable chain. Upstream connections to organizational/compliance context required.

## Output

Produce a structured summary:

```
## Intent Layer Assessment

### Findings
[List each finding with the rubric format]

### Intent Levels
| Level | State | Source | Citation |
|-------|-------|--------|----------|
| Organizational | Present/Absent/Unknown | Direct/Indirect/— | [file or reference] |
| Business | ... | ... | ... |
| Product | ... | ... | ... |
| Architecture | ... | ... | ... |
| Platform | ... | ... | ... |

- **Breadth**: X of 5 levels addressed
- **Depth**: [Traceable / Partially traceable / Fragmented]
- **Coherence**: [Aligned / Mixed / Contradictory]

### Upstream Context Connections
- **Direct**: [list with citations, or "None found"]
- **Indirect**: [list with citations, or "None found"]
- **Context isolation risk**: [Low / Medium / High]

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
