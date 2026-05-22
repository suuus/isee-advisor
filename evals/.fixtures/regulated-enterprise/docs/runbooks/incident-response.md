# Incident Response Runbook

## Severity Levels

- **P0**: PHI breach or service down > 15min → PagerDuty + Security + Legal immediately
- **P1**: Degraded service > 30min → Engineering on-call + Security awareness
- **P2**: Non-PHI issues, performance degraded → Engineering on-call

## P0 Procedure

1. **Contain**: Isolate affected service (do not delete logs)
2. **Notify**: Security lead + Legal within 1 hour
3. **Assess**: Determine PHI scope (which records, what data)
4. **Report**: HIPAA breach notification within 72 hours if > 500 records
5. **RCA**: Post-mortem within 5 business days

## HIPAA Breach Notification

If PHI of 500+ individuals affected: notify HHS and affected individuals within 60 days.
