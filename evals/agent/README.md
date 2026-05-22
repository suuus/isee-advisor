# Agent Integration Eval — Design Intent

**Status:** TODO — planned for PR 3

## Why this exists

The ISEE Advisor orchestrator (`.github/agents/isee-advisor.agent.md`) coordinates the full
assessment workflow across all four layer skills plus the report skill. An integration eval
here would verify the orchestrator's multi-turn behavior: does it invoke the right skills in
the right order, handle SKIPPED phases gracefully, and produce a coherent report?

## Waza constraint

Waza's `eval.yaml` requires a `skill:` field pointing to a named skill under `.github/skills/`.
The orchestrator agent is not a skill — it is an agent that invokes skills. Waza does not
currently support agent-level evals directly.

## PR 3 design

Options to explore in PR 3:
1. **Wrap the orchestrator as a skill** — create `.github/skills/isee-full-assessment/SKILL.md`
   that delegates to the orchestrator. Then `eval.yaml` can point to that skill.
2. **Waza agent executor** — if waza adds native agent eval support, point `eval.yaml` directly
   at `.github/agents/isee-advisor.agent.md`.
3. **Integration test harness** — run the orchestrator end-to-end against a full fixture and
   validate the output with a script rather than waza.

## What the eval would test

- Orchestrator invokes all 4 layer skills for a fixture with all signals present
- Orchestrator correctly skips agents phase for non-agent fixtures
- Final report reflects findings from all phases
- Orchestrator handles `ask_user` escalation correctly for incomplete input
