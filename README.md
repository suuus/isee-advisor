# ISEE Advisor

**Assess, advise, and track your team's alignment to the ISEE framework.**

ISEE (Intent · Structure · Execution · Evidence) is the operating framework for AI-native engineering teams, documented at [agentile.org](https://agentile.org). It answers: *If humans can no longer be in every loop, what structure does speed need?*

The ISEE Advisor is a [GitHub Copilot agent](https://docs.github.com/en/copilot) that scans your repo, evaluates how well your team implements each ISEE layer, and provides actionable recommendations. It assesses both informal framework signals and, when present, the machine-readable ADRP, ASRP, ISEE, and AERP protocol chain.

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

### Recommended: complete ISEE suite

```bash
copilot plugin marketplace add suuus/isee-plugins
copilot plugin install isee-suite@isee
```

The suite includes ISEE Advisor plus ADRP, ASRP, AERP, ISEE integration, and
the `isee-setup` skill.

To install only the advisor:

```bash
copilot plugin install isee-advisor@isee
```

### Manual copy for development

```bash
# Clone this repo
git clone https://github.com/suuus/isee-advisor.git

# Quick setup
cp -r path/to/isee-advisor/.github/agents/ .github/agents/
cp -r path/to/isee-advisor/.github/skills/isee-* .github/skills/
cp path/to/isee-advisor/plugin.json .
```
### Use as a git sub module

```bash
cd your-repo
git submodule add https://github.com/suuus/isee-advisor.git .isee-advisor
# Then symlink or copy what you need into .github/
```

## How It Works

The advisor scans your repo for signals across each ISEE layer:

| Layer | What it looks for |
|-------|-------------------|
| **Intent** | Explicit outcomes, priorities, decision criteria, ADRs, and ADRP records |
| **Structure** | Ownership, components, interfaces, boundaries, codified guardrails, and ASRP records |
| **Execution** | Work following an approved entry point, required gates, and an immutable execution manifest |
| **Evidence** | CI and operational signals, AERP records, exact bindings, verification, and feedback loops |

### Framework maturity and protocol conformance

The advisor keeps two questions separate:

1. **Framework maturity:** Does the team express Intent, establish Structure, execute coherently, and learn from Evidence?
2. **Protocol conformance:** Can those layers be traced and verified through exact machine-readable records?

A repository does not need the profile tooling to demonstrate strong ISEE maturity. When protocol artifacts are present, however, the advisor checks the stronger chain:

```text
ADRP Intent
   ↓ exact fingerprint binding
ASRP Structure
   ↓ compiled execution manifest
Execution
   ↓ retained Intent and Structure fingerprints
AERP Evidence
   ↓ evaluated against manifest requirements
Intent review
```

Recognized artifacts include:

- ADRP `ape-decision-record/v1` records;
- ASRP `ape-structure-record/v1` records;
- ISEE `isee-execution-manifest/v1` manifests and `.github/isee/` projections;
- AERP `aerp-evidence-record/v1` records and bundles.

If the relevant CLIs are installed, the advisor may run their read-only validation, verification, and evaluation commands. It never executes or deploys the assessed system.

**Product boundary:** `isee` governs a specific execution; `isee-advisor`
assesses whether a repository or team has a healthy ISEE operating system.

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

- **[ISEE Framework](https://agentile.org)** — The operating framework for AI-native engineering teams
- **[Ape Context](https://github.com/suuus/ape-context)** — Set up your context layer (MCP servers, copilot-instructions)
- **[ADRP](https://github.com/suuus/adrp)** — Durable, machine-readable Intent records
- **[ASRP](https://github.com/suuus/asrp)** — Durable Structure records and execution manifests
- **[AERP](https://github.com/suuus/aerp)** — Durable Evidence records and bundles
- **[ISEE Integration](https://github.com/suuus/isee)** — Preflight, Copilot projection, and Evidence evaluation
- **[Engineering Beyond Agile](https://thesuzannedaniels.substack.com)** — The 8-part article series behind ISEE
- **[ISEE Plugins](https://github.com/suuus/isee-plugins)** — Install the complete Copilot suite

## License

MIT — see [LICENSE](LICENSE).
