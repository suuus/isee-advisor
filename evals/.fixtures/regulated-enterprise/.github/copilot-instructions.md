# Copilot Instructions — HealthData Platform

## Priorities

1. **Compliance** — HIPAA, SOC 2 Type II; never trade compliance for speed
2. **Security** — encryption everywhere, least-privilege access, audit all PHI access
3. **Reliability** — 99.9% uptime; prefer fail-safe over fail-open
4. **Auditability** — every action attributable to a person or system

## Decision criteria

- Any change touching PHI fields requires Risk + Legal review (see CODEOWNERS)
- Encryption at rest required for all new data stores (ADR-0002)
- Dependencies with known CVEs must be patched within 48 hours (critical) / 2 weeks (high)
