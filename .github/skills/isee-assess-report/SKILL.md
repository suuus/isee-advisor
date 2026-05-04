---
name: isee-assess-report
description: Compile findings from all four ISEE layers into a scored maturity report with recommendations.
user-invocable: false
---

# Generate ISEE Assessment Report

Compile the findings from Phases 1–4 into a single, structured maturity report.

## Process

### 1. Gather findings
Collect all findings from the assessment phases:
- Intent (Phase 1) — including Intent Levels and upstream context connections
- Structure (Phase 2) — including upstream structural inheritance
- Execution (Phase 3) — including work item traceability
- Evidence (Phase 4) — including feedback loop traceability
- Agents (Phase 5, if run) — including per-agent ISEE and system assessment

Include findings from phases marked `[INCOMPLETE]` — note reduced confidence.
Exclude phases marked `[SKIPPED]` — note they were skipped by user request.

### 2. Score each layer

Score each layer on a 3-level scale:

| Score | Meaning |
|-------|---------|
| 🟢 **Strong** | Key signals present with high confidence. Minor gaps only. |
| 🟡 **Developing** | Some signals present, significant gaps exist. Clear path to improvement. |
| 🔴 **Weak** | Key signals absent or unknown. Foundational work needed. |

**Critical rule:** If most signals for a layer are **Unknown**, score as 🟡 Developing with a note: "Insufficient evidence to fully assess — score may improve with more data."

Never score 🔴 Weak based primarily on Unknown signals.

### 3. Generate the report

Use this format:

```markdown
# ISEE Assessment Report

**Repository:** {repo name}
**Date:** {date}
**Profile:** {Lightweight / Standard / Regulated}
**Assessed by:** ISEE Advisor (https://github.com/suuus/isee-advisor)

---

## Summary

| Layer | Score | Key Finding |
|-------|-------|-------------|
| Intent | 🟢/🟡/🔴 | {one-line summary} |
| Structure | 🟢/🟡/🔴 | {one-line summary} |
| Execution | 🟢/🟡/🔴 | {one-line summary} |
| Evidence | 🟢/🟡/🔴 | {one-line summary} |

**Overall maturity:** {narrative summary — 2-3 sentences}

---

## Intent Layer {score emoji}

### Strengths
{bulleted list of Present findings with citations}

### Gaps
{bulleted list of Absent findings with recommendations}

### Insufficient evidence
{bulleted list of Unknown findings with how to get more data}

### Intent Levels
| Level | State | Source | Citation |
|-------|-------|--------|----------|
| Organizational | Present/Absent/Unknown | Direct/Indirect/— | [ref] |
| Business | ... | ... | ... |
| Product | ... | ... | ... |
| Architecture | ... | ... | ... |
| Platform | ... | ... | ... |

- **Breadth**: X of 5 levels addressed
- **Depth**: [Traceable / Partially traceable / Fragmented]
- **Coherence**: [Aligned / Mixed / Contradictory]

---

## Structure Layer {score emoji}

{same format as Intent — Strengths, Gaps, Insufficient evidence}

### Upstream Structural Inheritance
- [shared CI, inherited configs, agent packages from distribution systems, compliance policy refs]

---

## Execution Layer {score emoji}

{same format}

### Work Item Traceability
- [Connected / Partial / None — with evidence]

---

## Evidence Layer {score emoji}

{same format}

### Evidence Upstream Flow
- Evidence **produced**: [sources]
- Evidence **consumed upstream**: [what informs decisions]
- **Feedback loop**: [Closed / Partial / Open]

---

## Context Chain Traceability

Cross-cutting assessment of how well context flows through the system:

### Evidence → Intent chain (bottom-up)
Can evidence be traced back through execution and structure to the intent it serves?
- **Grade**: [Traceable / Partially traceable / Fragmented / Unknown]
- **Evidence**: {what was found}

### Organizational → Platform chain (top-down)
Can intent be traced from organizational level down to platform-level decisions?
- **Grade**: [Traceable / Partially traceable / Fragmented / Unknown]
- **Evidence**: {what was found}

### Upstream context connections (across all layers)
| Layer | Direct | Indirect | Isolation Risk |
|-------|--------|----------|---------------|
| Intent | X connections | Y connections | Low/Medium/High |
| Structure | ... | ... | ... |
| Execution | ... | ... | ... |
| Evidence | ... | ... | ... |

---

## Agent & Agentic System Assessment
*(Only included when agent definitions were detected)*

### Per-Agent ISEE
| Agent | Intent | Structure | Execution | Evidence | Evidence Upstream |
|-------|--------|-----------|-----------|----------|-------------------|
| {name} | 🟢/🟡/🔴 | 🟢/🟡/🔴 | 🟢/🟡/🔴 | 🟢/🟡/🔴 | Flows/Partial/Trapped |

### System Assessment (if 2+ agents)
| Dimension | Score |
|-----------|-------|
| System Intent | Hierarchical / Flat-aligned / Disconnected |
| System Structure | Consistent / Partial / Inconsistent |
| System Execution | Well-partitioned / Some overlap / Fragmented |
| System Evidence | Flows upstream / Partially surfaces / Trapped |

### Agent Evidence Flow
- Agent output that **persists**: [list]
- Agent output that **informs decisions**: [list]
- Agent **feedback loop**: [does agent output improve agent config?]

---

## Top 3 Recommendations

Prioritized by impact and effort:

1. **{title}** — {description}. *Effort: {Low/Medium/High}. Impact: {description of what improves}.*
2. **{title}** — {description}. *Effort: {Low/Medium/High}. Impact: {description}.*
3. **{title}** — {description}. *Effort: {Low/Medium/High}. Impact: {description}.*

---

## Next Steps

- Re-run this assessment after implementing recommendations: `/isee-advisor drift`
- For deeper framework context: https://agentile.com/agents
- To set up your context layer (MCP servers, copilot-instructions): https://github.com/suuus/ape-context
- Full article series: https://thesuzannedaniels.substack.com

---

*Generated by [ISEE Advisor](https://github.com/suuus/isee-advisor) · ISEE Framework by Suzanne Daniels*
```

### 4. Present to user

Show the full report to the user. Then ask:

```
Use ask_user:
  message: "Here's your ISEE assessment. Would you like me to save it?"
  requestedSchema:
    properties:
      save:
        type: boolean
        title: "Save report to .github/isee-report.md?"
        description: "This creates a baseline for future drift detection."
        default: true
    required: [save]
```

If yes, write the report to `.github/isee-report.md`.
If no, the report remains in the conversation only.

### 5. Suggest Ape Context (if relevant)

If the assessment found gaps in Structure (no `.mcp.json`, no tool scoping) or Intent (no copilot-instructions.md), ask:

```
Use ask_user:
  message: "Your assessment found gaps in your context layer. Would you like to set up Ape Context to configure MCP servers and generate copilot instructions?"
  requestedSchema:
    properties:
      setup_ape_context:
        type: boolean
        title: "Set up Ape Context?"
        description: "Copies the context-wizard agent from github.com/suuus/ape-context into your repo."
        default: false
    required: [setup_ape_context]
```

Only ask this if gaps are relevant. Never push it on a team with strong structure.

## SQL Update

```sql
UPDATE todos SET status = 'done' WHERE id = 'assess-report';
```
