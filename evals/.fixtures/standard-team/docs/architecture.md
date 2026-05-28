# System Architecture Overview

## Components

```
Client → API Gateway → [Core Payments, Risk, Vault] → Postgres + Redis
```

- **API Gateway** (`src/gateway/`): Rate limiting, auth, request routing
- **Core Payments** (`src/payments/`): Transaction FSM, idempotency
- **Risk** (`src/risk/`): Rule engine, ML scoring, velocity checks
- **Vault** (external service): Card tokenization — no card data stored here

## Key design decisions

- All inter-service calls are synchronous HTTP; async via Postgres LISTEN/NOTIFY for settlement
- Retry logic uses exponential backoff with jitter (see `src/lib/retry.ts`)
- Feature flags via LaunchDarkly; all new features default-off in production

## Observability

- Structured JSON logs → Datadog
- Metrics: Datadog APM + custom transaction counters
- Alerts: PagerDuty on p99 > 300ms or error rate > 0.5%
