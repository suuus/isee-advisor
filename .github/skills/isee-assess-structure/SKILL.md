---
name: isee-assess-structure
description: |
  Score the Structure layer of ISEE. Read-only scan for codified constraints, guardrails, tool scoping, and trade-offs.

  USE FOR: assess structure, check guardrails, tool scoping, ci gates, security scanning, phase 2.

  DO NOT USE FOR: other ISEE layers, configuring MCP servers, modifying files.
user-invocable: false
---

# Assess Structure Layer

Score how well the team's constraints, guardrails, and trade-offs are codified — embedded in the environment so both people and agents follow them by default. Uses the ISEE rubric: Present/Absent/Unknown · High/Medium/Low confidence · Citation · Impact · Recommendation.

## Procedure

1. Scan files in [`references/rubric.md`](references/rubric.md) → *Scan targets*. Skip missing files.
2. Detect signals per *Structure signals* in the rubric (MCP tool scoping, CI gates, branch protection, security scanning).
3. Identify upstream structural inheritance: shared CI templates, org rulesets, remote agent packages.
4. If signals are insufficient, use the `ask_user` template in the rubric.
5. Score against user profile (Lightweight / Standard / Regulated). **Unknown ≠ Absent.**
6. Emit output per [`references/output.md`](references/output.md).
7. `UPDATE todos SET status = 'done' WHERE id = 'assess-structure';`

## Examples

- **Strong:** `.mcp.json` with scoped tools + CI with coverage threshold + Dependabot enabled → Present, High.
- **Gap:** All MCP servers at `"tools": ["*"]` + no branch protection + no security scanning → Absent.
- **Remote distribution:** Agent skills installed from a registry with policy enforcement → positive signal (centrally managed guardrails).

## Troubleshooting

- **Branch protection not visible from repo:** Use ask_user; do not assume absent.
- **MCP config is `"tools": ["*"]` everywhere:** That is a gap; flag it. Do not offer to reconfigure.
- **Compliance policy referenced but unreachable:** Record as a finding; don't ask user to retrieve.
- **Many Unknowns:** Score 🟡 Developing; never 🔴 based on Unknowns alone.
