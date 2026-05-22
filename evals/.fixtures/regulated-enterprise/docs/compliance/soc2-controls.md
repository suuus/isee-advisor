# SOC 2 Controls Reference

## CC6 — Logical and Physical Access Controls

- CC6.1: Access provisioned through IAM with least-privilege roles
- CC6.2: MFA required for all human access to production systems
- CC6.3: Access reviewed quarterly; terminated employees deprovisioned within 24h

## CC7 — System Operations

- CC7.1: Vulnerability scanning on all container images (see security-scan.yml)
- CC7.2: Intrusion detection via Datadog Cloud SIEM
- CC7.3: Incident response procedure in docs/runbooks/incident-response.md

## A1 — Availability

- A1.1: 99.9% uptime commitment; load-tested to 3x peak
- A1.2: RTO < 4h, RPO < 1h (tested quarterly in game days)
