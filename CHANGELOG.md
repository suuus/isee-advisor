# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.4.1] - 2026-10-02

### Changed
- Recommend the unified `suuus/isee-plugins` marketplace and complete
  `isee-suite` installation.
- Use [agentile.org](https://agentile.org) as the canonical ISEE framework
  reference in the advisor, skills, reports, and public documentation.

## [0.4.0] - 2026-10-02

### Added
- Separate protocol-conformance assessment for ADRP Intent, ASRP Structure, ISEE execution manifests, and AERP Evidence.
- Exact-chain checks for lifecycle, fingerprints, bindings, manifest consumption, gates, Evidence requirements, artifact integrity, and loop closure.
- Valid, mismatched-binding, and missing-Evidence protocol fixtures with Waza eval tasks.
- Public-repository contribution, conduct, security, issue, and pull-request guidance.
- General CI for manifest validation, agent/skill structure checks, and repository-wide Markdown linting.

### Changed
- Execution assessment now focuses on whether work follows approved entry points, manifests, gates, approvals, and Structure-defined responsibilities.
- Reports keep framework maturity independent from optional protocol adoption.
- Recommendations route context, Intent, Structure, Evidence, and integration gaps to Ape Context, ADRP, ASRP, AERP, or ISEE respectively.
- Drift detection now identifies lifecycle changes, fingerprint changes, binding mismatches, gate changes, and stale or unsatisfied Evidence.

## [0.3.0] - 2026-05-28

### Added
- New user-invocable skill `isee-orchestrate` — single source of truth for the full assess pipeline. Direct-invokable via `/isee-orchestrate`, also used by `/isee-advisor assess`.
- Full waza eval suite — 10 synthetic ISEE-shaped fixtures, 19 task evals across all 9 skills, agent-level orchestration eval. All passing at 1.00 aggregate.
- Per-skill `references/` modules — rubrics, output templates, ask_user templates moved out of `SKILL.md` for progressive disclosure.
- `evals/.baseline/` — before/after compliance snapshots for auditability.
- CI eval workflow `.github/workflows/eval.yml` — runs waza on PRs touching skills, evals, or `.waza.yaml`.

### Changed
- All 9 skills now pass agentskills.io compliance at **Medium-High** (from "Low"). `SKILL.md` files stay under the 500-token hard cap (was 994–2,734 tokens before).
- `agent.md` Assess mode reduced from 50+ lines of duplicated SQL + phase definitions to a single delegation to `isee-orchestrate`.
- Every skill gains `USE FOR:` / `DO NOT USE FOR:` triggers plus `## Examples` and `## Troubleshooting` sections.

### Fixed
- `cites_fixture` grader in `isee-assess-report` was brittle on singular/plural — replaced literal substring check with case-insensitive regex.
- `marketplace.json` version skew (was stuck at `0.1.0` since initial release) now back in sync with `plugin.json`.

## [0.2.1] - 2026-05-04

### Fixed
- Follow the context chain — don't ask users to be middlemen.
- Prevent agent from offering to configure MCP servers during assessment.

## [0.2.0] - 2026-05-04

### Added
- Intent levels for granular assessment.
- Upstream context discovery.
- Agent ISEE assessment mode (`isee-assess-agents`).

## [0.1.0] - 2026-04-29

### Added
- Initial release.
- Assess mode — scan repo and score ISEE maturity.
- Advise mode — contextual ISEE guidance.
- Drift mode — compare against prior assessments.
- Skills for each ISEE layer (Intent, Structure, Execution, Evidence).
- Assessment report compiler.

[0.3.0]: https://github.com/suuus/isee-advisor/compare/v0.2.1...v0.3.0
[0.4.0]: https://github.com/suuus/isee-advisor/compare/v0.3.0...v0.4.0
[0.4.1]: https://github.com/suuus/isee-advisor/compare/v0.4.0...v0.4.1
[0.2.1]: https://github.com/suuus/isee-advisor/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/suuus/isee-advisor/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/suuus/isee-advisor/releases/tag/v0.1.0
