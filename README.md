# ISEE Advisor

**Assess, advise, and track your team's alignment to the ISEE framework.**

ISEE (Intent · Structure · Execution · Evidence) is the operating framework for AI-native engineering teams, created by [Suzanne Daniels](https://thesuzannedaniels.substack.com). It answers: *If humans can no longer be in every loop, what structure does speed need?*

The ISEE Advisor is a [GitHub Copilot agent](https://docs.github.com/en/copilot) that scans your repo, evaluates how well your team implements each ISEE layer, and provides actionable recommendations.

## Modes

### 🔍 Assess
Scan your repo and score ISEE maturity across all four layers. Produces a structured report with findings, confidence levels, and prioritized recommendations.

```
/isee-advisor assess
```

### 💡 Advise
Ask any ISEE question or describe a scenario. Get practical, opinionated guidance grounded in the framework.

```
/isee-advisor advise
```

### 🔄 Drift
Re-assess after making changes. Compare against your prior assessment to see what improved, regressed, or is new.

```
/isee-advisor drift
```

## Installation

1. Copy the `.github/agents/` and `.github/skills/` directories into your repository
2. Copy `plugin.json` to your repo root
3. Invoke the agent through GitHub Copilot

```bash
# Quick setup
cp -r path/to/isee-advisor/.github/agents/ .github/agents/
cp -r path/to/isee-advisor/.github/skills/isee-* .github/skills/
cp path/to/isee-advisor/plugin.json .
```

## How It Works

The advisor scans your repo for signals across each ISEE layer:

| Layer | What it looks for |
|-------|-------------------|
| **Intent** | Explicit outcome statements, priorities, decision criteria in README, docs, copilot-instructions |
| **Structure** | Codified constraints, CI guardrails, tool scoping, security policies, cost boundaries |
| **Execution** | Team topology (CODEOWNERS), context-rich PRs, agent definitions, workflow documentation |
| **Evidence** | CI reporting, monitoring config, alerting, deployment verification, feedback loops |

### Assessment Rubric

Every finding includes:
- **State**: Present / Absent / Unknown
- **Confidence**: High / Medium / Low
- **Citation**: Where the evidence was found
- **Impact**: Why it matters
- **Recommendation**: What to do about it

**Unknown ≠ Weak.** Missing data is reported honestly — never scored as a failure.

### Maturity Profiles

The assessment calibrates expectations based on your team's context:
- **Lightweight** — Startup/small team. Informal structure is fine.
- **Standard** — Established team. Moderate process expected.
- **Regulated** — Compliance-heavy. Audit-grade evidence required.

## Related

- **[ISEE Framework](https://agentile.com/agents)** — Full framework instructions for agents
- **[Ape Context](https://github.com/suuus/ape-context)** — Set up your context layer (MCP servers, copilot-instructions)
- **[Engineering Beyond Agile](https://thesuzannedaniels.substack.com)** — The 8-part article series behind ISEE
- **[Agentile](https://agentile.com)** — The operating model for AI-native teams

## License

MIT — see [LICENSE](LICENSE).
