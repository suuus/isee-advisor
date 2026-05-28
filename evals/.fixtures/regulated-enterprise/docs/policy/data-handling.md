# Data Handling Policy

## PHI Classification

All data fields are classified at ingestion:
- **PHI**: name, DOB, SSN, diagnosis codes, provider identifiers
- **PII**: email, phone, address (may or may not be PHI depending on context)
- **Non-sensitive**: anonymized aggregate stats

## Encryption Requirements

- PHI at rest: AES-256 via Postgres `pgcrypto` (see ADR-0002)
- PHI in transit: TLS 1.3 minimum; no TLS 1.2 fallback
- Keys managed in AWS KMS; rotation every 90 days

## Retention

- PHI retained for 7 years post care episode (HIPAA minimum)
- Audit logs retained for 6 years
- Deletion requests: 30-day SLA, legal hold check required
