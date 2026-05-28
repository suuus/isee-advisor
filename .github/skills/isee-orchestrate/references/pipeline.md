# Pipeline — phase SQL + ordering

## Seed todos

```sql
INSERT INTO todos (id, title, description, status) VALUES
  ('assess-intent',    'Phase 1: Assess Intent layer',     'Scan for explicit intent statements, outcome definitions, decision criteria, intent levels, upstream context', 'pending'),
  ('assess-structure', 'Phase 2: Assess Structure layer',  'Check for codified constraints, guardrails, tool scoping, trade-offs, upstream structural inheritance', 'pending'),
  ('assess-execution', 'Phase 3: Assess Execution layer',  'Evaluate team topology signals, context distribution, coordination patterns, work item traceability', 'pending'),
  ('assess-evidence',  'Phase 4: Assess Evidence layer',   'Check for feedback loops, monitoring, CI checks, reporting patterns, evidence upstream flow', 'pending'),
  ('assess-agents',    'Phase 5: Assess Agents (optional)','Evaluate agents and agentic systems through the ISEE lens — only if agent definitions detected', 'pending'),
  ('assess-report',    'Phase 6: Generate ISEE report',    'Compile findings into scored maturity report with intent levels, context chain, agent assessment, recommendations', 'pending');

INSERT INTO todo_deps (todo_id, depends_on) VALUES
  ('assess-structure', 'assess-intent'),
  ('assess-execution', 'assess-structure'),
  ('assess-evidence',  'assess-execution'),
  ('assess-agents',    'assess-evidence'),
  ('assess-report',    'assess-agents');
```

## Execution rules

| Outcome | Action |
|---------|--------|
| Phase succeeds | `UPDATE todos SET status='done' WHERE id='<phase-id>'`, proceed |
| Phase incomplete (missing data, partial access) | Mark `[INCOMPLETE]` in the phase output, set status `done`, proceed |
| Phase skipped (no relevant signals — e.g., no agents) | Mark `[SKIPPED]` with reason, set status `done`, proceed |
| Phase fails (tool error, model failure) | Mark `[FAILED]` with reason, set status `done`, proceed |

**Never block downstream phases.** A partial report with documented gaps is more useful than a hung pipeline.

## Skill mapping

| Phase | Skill |
|-------|-------|
| 1. Intent | `isee-assess-intent` |
| 2. Structure | `isee-assess-structure` |
| 3. Execution | `isee-assess-execution` |
| 4. Evidence | `isee-assess-evidence` |
| 5. Agents (optional) | `isee-assess-agents` — only if `.github/agents/*.agent.md` or `.github/skills/*/SKILL.md` detected |
| 6. Report | `isee-assess-report` — runs always, compiles all completed phases |
