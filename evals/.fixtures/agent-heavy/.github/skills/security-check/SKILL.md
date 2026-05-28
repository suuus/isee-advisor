---
name: security-check
description: Scan a code file for security vulnerabilities (injection, secrets, auth bypass).
user-invocable: false
---

# Security Check Skill

## Inputs

- File path and content (passed from reviewer agent)

## Procedure

1. Scan for hardcoded secrets (API keys, passwords, tokens)
2. Check for injection vectors (SQL, command, LDAP)
3. Check for insecure patterns (eval, dangerouslySetInnerHTML, pickle.loads)
4. Return findings array: `[{ "severity": "CRITICAL|HIGH|MEDIUM|LOW", "line": N, "description": "...", "recommendation": "..." }]`

## Guardrails

- Only read the provided file — do not traverse the filesystem
- Return empty array if no issues found (not null)
