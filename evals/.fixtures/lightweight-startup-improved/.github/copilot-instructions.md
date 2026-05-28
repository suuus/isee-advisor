# Copilot Instructions — Tasks API

## Priorities

1. **Speed** — offline sync must complete in < 2s on slow connections
2. **Simplicity** — 3-person team; prefer readable over clever
3. **Reliability** — beta users are design partners; don't break their data

## Decision criteria

- If a feature risks breaking offline sync, defer to next sprint
- Prefer Postgres over Redis for simplicity unless profiling shows we need cache
