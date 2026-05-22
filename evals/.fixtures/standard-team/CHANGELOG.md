# Changelog

## [2.4.1] - 2024-03-10

### Fixed
- Retry logic now respects idempotency key on network timeout (#312)
- Risk score not computed for refund requests (#308)

## [2.4.0] - 2024-03-01

### Added
- Merchant onboarding API v2 with webhook support
- Feature flag: `new-settlement-flow` (default off)

### Changed
- Fastify migration complete for /payments routes (ADR-0001)

## [2.3.0] - 2024-02-15

### Added
- Velocity checks for card-not-present transactions
- CHANGELOG.md (this file)
