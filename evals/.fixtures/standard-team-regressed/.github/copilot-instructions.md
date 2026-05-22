# Copilot Instructions — Payments Platform

## Priorities (in order)

1. **Reliability** — never break the payment path; prefer defensive code
2. **Security** — PCI DSS compliance; no card data outside vault
3. **Latency** — p99 < 200ms for core transaction flow
4. **Developer velocity** — boring, predictable code wins

## Decision criteria

- If a change could widen PCI scope, block it and escalate to Risk squad
- Prefer Fastify route handlers over Express middleware patterns (see ADR-0001)
- All new features require a feature flag; no dark launches without observability

## What to skip

- Do not suggest adding new npm dependencies without a discussion in #platform-eng
- Do not rewrite existing retry logic — it is load-tested and intentional
