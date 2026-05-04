---
name: isee-assess-agents
description: Assess agents and agentic systems through the ISEE lens — evaluate whether agents have clear intent, structure, execution boundaries, and produce evidence that flows upstream.
user-invocable: false
---

# Assess Agents & Agentic Systems

Evaluate whether agents defined in this repository follow the ISEE framework — and whether multi-agent systems maintain alignment across Intent, Structure, Execution, and Evidence. This phase is **optional** — only triggered when agent definitions are detected.

## When to run

Run this phase when any of the following are present:
- `.github/agents/*.agent.md` — agent definitions
- `.github/skills/*/SKILL.md` — skill playbooks
- `.github/copilot-instructions.md` with agent-specific sections
- `.mcp.json` with tool scoping per context

Skip this phase if no agent definitions are found. Mark as `[SKIPPED]` with note: "No agent definitions detected."

## What to scan

1. **Agent definitions**: `.github/agents/*.agent.md` — each agent's purpose, rules, constraints, output patterns
2. **Skill playbooks**: `.github/skills/*/SKILL.md` — scoped responsibilities, input/output contracts, execution patterns
3. **Copilot instructions**: `.github/copilot-instructions.md` — shared agent context, cross-agent rules
4. **MCP config**: `.mcp.json` — tool access per agent/context, read-only vs read-write scoping
5. **Agent workflows**: `.github/workflows/*.yml` — agent-triggered automation, CI integration with agents
6. **Agent output artifacts**: Look for patterns where agents write findings, reports, or logs (e.g., `.github/isee-report.md`, generated docs)
7. **Agent packaging/distribution manifests**: Check for signs that agent context is remotely distributed — package manifests, lockfiles, dependency declarations, installed module directories, or policy files that govern agent packages. These indicate agent intent, structure, or execution boundaries are centrally managed and distributed rather than defined only locally.

### Remote distribution as a signal

When agent context comes from a packaging or distribution system (rather than being defined only in the local repo), this is a strong signal — it means intent, structure, and execution boundaries can be centrally managed, versioned, and consistently applied across repos.

**What to look for:**
- Package manifests or lockfiles that declare agent dependencies (skills, instructions, agent definitions sourced from external repos or registries)
- Policy files that enforce organizational constraints on what agent packages are allowed
- Installed module directories containing downloaded agent primitives
- Versioning and reproducibility signals (pinned versions, content hashes, lockfiles)

**What these systems typically carry for ISEE:**
- **Intent**: Skill/agent descriptions that define purpose and when to use
- **Structure**: Always-loaded instructions (guardrails), organizational policy enforcement, tool scoping declarations
- **Execution**: Agent type/mode definitions, compatibility requirements, dependency graphs between agent packages
- **Evidence**: ⚠️ Typically a gap — most agent packaging systems do not natively define what evidence an agent should produce. This is where ISEE adds unique value.

**Key assessment question:** When agent context comes from a remote source, can you trace it back to its origin? Is it versioned? Is there governance over what gets installed? Does the upstream source carry intent, or just code?

## What to look for — per agent

Assess each discovered agent against all four ISEE layers:

### Agent Intent (does the agent have clear, scoped purpose?)

**PRESENT signals:**
- Explicit role statement ("You are the X advisor" or "You handle Y")
- Scoped boundaries ("I do X, not Y", "This agent focuses on...")
- Outcome orientation (agent purpose defined in terms of what it achieves, not just what it does)
- Clear distinction from other agents (no ambiguous overlap)
- Intent readable by both humans and other agents

**ABSENT signals:**
- Generic purpose ("You are a helpful assistant")
- No boundaries — agent tries to do everything
- Purpose described only in terms of actions, not outcomes
- Indistinguishable from other agents in the system

### Agent Structure (does the agent have guardrails?)

**PRESENT signals:**
- Tool scoping in `.mcp.json` (not `"tools": ["*"]` — specific tools listed)
- Explicit constraints ("do not merge", "do not deploy", "read-only")
- Read-only vs read-write boundaries clearly defined
- Error handling rules (what to do when uncertain, when to escalate)
- Operating rules section in agent definition
- Skill-level constraints (each skill has scoped responsibilities)

**ABSENT signals:**
- All tools available to all agents (no scoping)
- No explicit "do not" rules
- No escalation path defined
- No distinction between read and write operations
- Agent can modify anything without approval

### Agent Execution (are responsibilities well-distributed?)

**PRESENT signals:**
- Clear division of responsibility between agents (no overlapping domains)
- Handoff points defined (when Agent A should invoke/defer to Agent B)
- Scoped file/domain access per agent
- Workflow patterns documented (phased execution, dependency chains)
- Skills map to specific responsibilities (not catch-all)
- Escalation paths to humans defined

**ABSENT signals:**
- Multiple agents with overlapping responsibilities
- No defined handoff patterns
- Agents operating in isolation (no awareness of other agents)
- Monolithic agent doing everything
- No human escalation path

### Agent Evidence (does the agent produce reviewable output that flows upstream?)

**This is the critical layer for agents.** An agent that acts but produces no reviewable evidence is a black box.

**PRESENT signals:**
- **Citations in output**: Agent cites sources for its decisions (file paths, line numbers, URLs)
- **Structured findings**: Output follows a reviewable format (not just prose dumps)
- **Decision logging**: Agent explains *why* it made a choice, not just *what* it did
- **Audit trail**: Agent actions can be traced after the fact (SQL todos, status updates, saved reports)
- **Evidence → human review flow**: Agent output is designed to be reviewed by humans (clear summaries, actionable items)
- **Evidence → upstream decisions**: Agent-produced evidence informs team decisions (e.g., assessment findings → priority changes, drift reports → backlog items)
- **Feedback loop**: Evidence from agent output flows back to agent configuration (reports inform instruction updates, findings lead to guardrail changes)
- **Verify-after-action patterns**: Agent instructions include "check your work", "verify the output", "confirm before proceeding"

**ABSENT signals:**
- Agent produces output but doesn't cite sources
- Output is unstructured prose with no clear findings
- No explanation of decisions — just results
- Actions are not logged or traceable
- Output stays in conversation — never persisted or surfaced
- No connection between agent output and team decisions
- No feedback loop — agent config never updated based on its own findings
- Agent acts autonomously with no human review checkpoint

**Evidence upstream flow — key questions:**
When assessing agent evidence, specifically check:
1. Can a human **trace** what the agent decided and why?
2. Does agent output **reach** decision-makers (saved reports, notifications, PR comments)?
3. Does agent evidence **change** the next decision (findings → backlog, scores → priorities)?
4. Is there a **closed loop** where agent output improves agent configuration over time?

## What to look for — multi-agent system

When **2 or more agents** are detected, assess the system as a whole:

### System Intent
- Is there an **intent hierarchy**? (orchestrator agent → specialist agents, or shared mission)
- Do agents share a **common purpose**, or are they disconnected?
- Is there a **parent intent** that child agents serve? (e.g., "improve engineering quality" → assess agent + context agent + review agent)
- Does the system's collective purpose align with the repo's **organizational/business intent**?

### System Structure
- Are **guardrails consistent** across agents? (e.g., all agents respect read-only constraints)
- Are **tool permissions scoped per agent**, not shared broadly?
- Are **boundaries between agents clear** and non-overlapping?
- Is there a **coordination pattern**? (orchestrator, pipeline, event-driven, or ad hoc?)

### System Execution
- Are **responsibilities partitioned without gaps or overlaps**?
- Are **handoffs between agents defined**? (Agent A finishes → Agent B starts)
- Is there an **orchestration pattern** visible? (agent.md with phased workflow, skill chains)
- Do agents **share context** appropriately? (not duplicating work, not missing context)

### System Evidence (upstream flow across agents)
- Does evidence from **one agent flow to another's context**? (e.g., assessment findings available to advise mode)
- Is there **system-level observability**? (can you see what all agents did collectively?)
- Does evidence **roll up** from agent-level to system-level? (individual findings → aggregate report)
- Does system evidence **surface to human decision-makers**? (not trapped inside agent conversations)
- Can a human **trace through the system**: *what was decided → by which agent → based on what evidence → why*?
- Is there a **system feedback loop**? Agent output → human review → configuration update → improved agent behavior?

## Scoring

### Per-agent scoring
For each agent, score all four ISEE layers using the standard rubric:
- Signal, State (Present/Absent/Unknown), Confidence, Citation, Impact, Recommendation

Then assign a per-agent ISEE grade:
- 🟢 **Strong**: Clear intent, scoped structure, clean execution boundaries, evidence flows upstream
- 🟡 **Developing**: Some layers strong, others have gaps. Evidence may exist but doesn't consistently flow upstream
- 🔴 **Weak**: Unclear purpose, no guardrails, overlapping responsibilities, or black-box output

### System scoring (when 2+ agents)
Score the system on the four system-level signals:
- **System Intent**: Hierarchical / Flat-aligned / Disconnected
- **System Structure**: Consistent / Partial / Inconsistent
- **System Execution**: Well-partitioned / Some overlap / Fragmented
- **System Evidence**: Flows upstream / Partially surfaces / Trapped

### Profile-adjusted expectations
- **Lightweight**: 1-2 agents with clear purpose and basic guardrails is strong. Evidence = structured output in conversation.
- **Standard**: Agents with scoped tools, defined boundaries, and evidence that persists (saved reports, PR comments). System-level coordination visible.
- **Regulated**: Agents with audit-grade evidence trails, explicit escalation paths, tool access logs, and evidence that demonstrably informs decisions. System traceability required.

## Output

```
## Agent & Agentic System Assessment

### Agents Detected
[List each agent with file path]

### Per-Agent ISEE Assessment

#### {Agent Name} (`{file path}`)
| Layer | Score | Key Finding |
|-------|-------|-------------|
| Intent | 🟢/🟡/🔴 | {one-line} |
| Structure | 🟢/🟡/🔴 | {one-line} |
| Execution | 🟢/🟡/🔴 | {one-line} |
| Evidence | 🟢/🟡/🔴 | {one-line} |

**Evidence upstream flow**: [Flows to decisions / Partially surfaces / Trapped in conversation]

[Repeat for each agent]

### Multi-Agent System Assessment
*(Only if 2+ agents detected)*

| Dimension | Score | Finding |
|-----------|-------|---------|
| System Intent | Hierarchical/Flat-aligned/Disconnected | {one-line} |
| System Structure | Consistent/Partial/Inconsistent | {one-line} |
| System Execution | Well-partitioned/Some overlap/Fragmented | {one-line} |
| System Evidence | Flows upstream/Partially surfaces/Trapped | {one-line} |

### Evidence Upstream Flow Analysis
- Evidence **produced** by agents: [list what agents output]
- Evidence **persisted**: [list what gets saved vs conversation-only]
- Evidence **reaching humans**: [how findings surface to decision-makers]
- Evidence **closing the loop**: [does output inform next configuration/decision?]

### Summary
- Agents assessed: X
- Agents with strong evidence flow: Y
- System coordination: [description]
- Key strength: [what's working]
- Key gap: [most impactful missing signal]
- Top recommendation: [single most valuable next step]
```

## SQL Update

```sql
UPDATE todos SET status = 'done' WHERE id = 'assess-agents';
```
