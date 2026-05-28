# ADR 0002: PostgreSQL pgcrypto for PHI Encryption at Rest

**Status:** Accepted  
**Date:** 2024-02-01  
**Deciders:** Engineering, Security, Legal

## Context

HIPAA requires encryption at rest for all PHI. We evaluated: application-layer encryption, Postgres `pgcrypto`, transparent data encryption (TDE) via RDS.

## Decision

Use `pgcrypto` for PHI columns. KMS-managed keys via AWS Secrets Manager.

## Consequences

**Positive:** Defense-in-depth; PHI unreadable even if DB dump exfiltrated.
**Negative:** 15-20% query overhead on PHI lookups; key rotation requires re-encryption job.

## Alternatives rejected

- TDE: Doesn't protect against privileged DB user access
- App-layer encryption: Harder to enforce uniformly; schema migrations more complex
