# Payments Platform

A backend payment processing service serving 40k merchants. Owned by three squads:
- **Core Payments** — transaction processing, settlement, reconciliation
- **Risk** — fraud detection, velocity checks, dispute handling
- **Platform** — API gateway, developer portal, integrations

## Outcomes we're pursuing

1. Process payments with < 200ms p99 latency (reliability before features)
2. Zero PCI scope creep — all card data stays in the vault service
3. Merchant onboarding under 5 minutes end-to-end
4. < 1% failed-payment rate with automatic retry logic
5. Deprecate legacy PHP monolith by Q3

## Architecture decisions

See [docs/adr/](docs/adr/) for all Architecture Decision Records.
Full system overview in [docs/architecture.md](docs/architecture.md).

## Contributing

See [.github/pull_request_template.md](.github/pull_request_template.md) for the PR format we use.
