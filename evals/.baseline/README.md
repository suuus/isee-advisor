# Baseline — before waza compliance work

Captured before any SKILL.md edits in PR 1.
Generated with `waza check` and `waza coverage` on `waza` (binary).

## Coverage (after `waza init`)

| Skill | Tasks | Graders | Coverage |
|-------|-------|---------|----------|
| isee-advise | 1 | code, text | ✅ Full |
| isee-assess-agents | 1 | code, text | ✅ Full |
| isee-assess-evidence | 1 | code, text | ✅ Full |
| isee-assess-execution | 1 | code, text | ✅ Full |
| isee-assess-intent | 1 | code, text | ✅ Full |
| isee-assess-report | 1 | code, text | ✅ Full |
| isee-assess-structure | 1 | code, text | ✅ Full |
| isee-drift | 1 | code, text | ✅ Full |

> Note: scaffolds are placeholders with generic regex graders. PR 2 replaces them with skill-specific evals against real fixtures.

## Compliance — all skills "Low"

| Skill | SKILL.md tokens | Description chars | Status |
|-------|----------------:|------------------:|--------|
| isee-advise           |    994 |  87 | ❌ Low |
| isee-assess-agents    |  2,734 |   — | ❌ Low |
| isee-assess-evidence  |  1,619 | 105 | ❌ Low |
| isee-assess-execution |  1,317 | 101 | ❌ Low |
| isee-assess-intent    |  2,062 | 106 | ❌ Low |
| isee-assess-report    |  1,774 |  94 | ❌ Low |
| isee-assess-structure |  1,413 | 102 | ❌ Low |
| isee-drift            |  1,427 | 114 | ❌ Low |
| **Total**             | **13,340** | — | **0/8 pass** |

Token limit: **500** per `SKILL.md` (hard cap). Currently exceeded by 12,840 tokens total.
Description limit: **150 chars** with `USE FOR:` / `DO NOT USE FOR:` triggers.

## Universal advisory failures

Every skill flags the same three patterns:

1. `[procedural-content]` — descriptions don't use action-verb lead words.
2. `[body-structure]` — no `## Examples` section, no `## Troubleshooting` section.
3. `[spec-allowed-fields]` — `user-invocable: true` is not in agentskills.io's allowed-fields list.

> The `user-invocable` field is Copilot-CLI specific (gates the slash-command picker). It is intentionally retained. The advisory is acknowledged, not actioned.

## Raw output

Full `waza check` output in [`check.txt`](./check.txt).
