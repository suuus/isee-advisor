---
name: isee-assess-execution
description: |
  Score the Execution layer of ISEE. Read-only scan for team topology, context distribution, and coordination patterns.

  USE FOR: assess execution, team topology, context distribution, coordination patterns, phase 3.

  DO NOT USE FOR: other ISEE layers, modifying files, reorganizing teams.
user-invocable: false
---

# Assess Execution Layer

Score how the team ships — whether coordination is distributed through artifacts and context, or trapped in handoffs and meetings. Uses the ISEE rubric: Present/Absent/Unknown · High/Medium/Low confidence · Citation · Impact · Recommendation.

## Procedure

1. Scan files in [`references/rubric.md`](references/rubric.md) → *Scan targets*. Skip missing files.
2. Detect signals per *Execution signals* in the rubric (CODEOWNERS, PR templates, commit messages, agent definitions).
3. Scan for work item traceability: commit messages for `fixes`, `closes`, `AB#`, `JIRA-` patterns.
4. If signals are insufficient, use the `ask_user` template in the rubric.
5. Score against user profile (Lightweight / Standard / Regulated). **Unknown ≠ Absent.**
6. Emit output per [`references/output.md`](references/output.md).
7. `UPDATE todos SET status = 'done' WHERE id = 'assess-execution';`

## Examples

- **Strong:** CODEOWNERS with module-level ownership + PR template asking "What problem does this solve?" → Present, High.
- **Weak:** Single `* @team` in CODEOWNERS + checklist-only PR template + generic commit messages → Absent.
- **Unknown:** No CODEOWNERS but user describes service-oriented teams → Unknown, use ask_user.

## Troubleshooting

- **No CODEOWNERS:** Not always a gap for Lightweight teams; check PR template richness instead.
- **Generic commit messages:** Only flag as Absent if the PR template also lacks context fields.
- **External coordination tools:** Attempt to follow Jira/ADO references; if unreachable, record as a finding.
- **Many Unknowns:** Score 🟡 Developing; never 🔴 based on Unknowns alone.
