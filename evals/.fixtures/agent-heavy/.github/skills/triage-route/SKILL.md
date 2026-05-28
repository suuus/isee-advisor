---
name: triage-route
description: Classify a GitHub issue into bug/feature/question/security and return routing metadata.
user-invocable: false
---

# Triage Route Skill

## Inputs

- Issue title and body (passed from triage agent)

## Procedure

1. Analyze issue content for classification signals
2. Return structured JSON: `{ "type": "bug|feature|question|security", "confidence": 0.0-1.0, "squad": "core|platform|security", "rationale": "..." }`

## Classification rules

- `security`: mentions credentials, auth bypass, injection, CVE, vulnerability
- `bug`: describes unexpected behavior with reproduction steps
- `feature`: requests new capability
- `question`: asks for help or clarification
