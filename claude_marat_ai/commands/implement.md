description: Implement the plan with playbook, reflector, and curator
argument-hint: <folder-or-file-with-plan>
allowed-tools: Grep, Glob, Read, Write, Bash, Bash(git:*), Bash(rg:*), Bash(ls:*), Bash(tree:*)
---

# Task
Implement the plan specified by the user.
If the user doesn't specify the plan, propose to provide one or create it with `/prepare-feature` and `/plan`.

# Instructions 

1) Preflight & Inputs
- Validate inputs (plan path or direct instructions). If missing, offer `/prepare-feature` then `/plan`.
- If `PLAYBOOK.md` doens't exists at repo root create an empty one

2) Add additional tasks before and after each implementaion step (task in todo):
  - Before each task in the todo add the task to retrieve relevant bullets from PLAYBOOK.md:
    - Rank = (helpful_count − harmful_count) + recency boost + similarity to subtask text (simple substring/`rg` hits suffice).
  - After each task in the todo add the task to write the trace (logs of how task was implemented) to TRACE_<task>_<time>.md and run reflector agent on that trace.

# Trace logging
After completing the task or failing to do so write all the thoughts and tool calls (export entire conversaion) to TRACE_<task>_<time>.md.
Also write the full trace before all comapctions happening, so no infornation is lost.

# PLAYBOOK.md format
Bullet Item — Conceptual schema
  - id: string (assigned by system)
  - section: string (domain-specific)
  - helpful_count: int
  - harmful_count: int
  - content: string
  - tags: string[] (optional)