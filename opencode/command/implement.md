description: Implement the plan with ACE (Generator→Reflector→Curator)
argument-hint: <folder-or-file-with-plan>
allowed-tools: Grep, Glob, Read, Write, Bash, Bash(git:*), Bash(rg:*), Bash(ls:*), Bash(tree:*)
---

# Task
Implement the plan specified by the user using ACE-style adaptation.
If the user doesn't specify the plan, propose to provide one or create it with `/prepare-feature` and `/plan`.

# Instructions
Divide the implementation plan into consecutive phases and show them to the user before running:

1) Preflight & Inputs
- Validate inputs (plan path or direct instructions). If missing, offer `/prepare-feature` then `/plan`.
- Ensure `PLAYBOOK.md` exists at repo root with sections:
  - strategies_and_hard_rules
  - apis_to_use_for_specific_information
  - verification_checklist
  - formulas_and_calculations
  - failures_and_resolutions

1) Implement
- Before each subtask, retrieve relevant bullets from PLAYBOOK.md:
  - Rank = (helpful_count − harmful_count) + recency boost + similarity to subtask text (simple substring/`rg` hits suffice).
  - Show the selected bullet_ids and contents to the user for transparency.
- Execute the subtask in small, verifiable steps.
- On any tool/command failure, immediately append a provisional bullet under `failures_and_resolutions` describing the failure and suspected cause.

1) Reflect
- After each subtask (or checkpoint):
  - Save the full conversation to `TRACE_<task>_<time>.md`
  - Invoke the reflector agent with:
    - Task/subtask context
    - Relevant playbook bullets used (ids and text) from PLAYBOOK.md
    - TRACE_<task>_<time>.md file path
  - Expect reflector to produce REFLECTION_<task>_<time>.md file with reasoning, error_identification, root_cause_analysis, correct_approach, key_insight, and bullet_tags (id → helpful|harmful|neutral) when applicable.

1) Curate
- Run the curator agent with: 
  - task context
  - current playbook PLAYBOOK.md
  - recent reflection REFLECTION_<task>_<time>.md files
- Expect curator agent to produce ADD_TO_PLAYBOOK.md
- Apply only NEW, non-redundant bullets from ADD_TO_PLAYBOOK.md to PLAYBOOK.md. Assign fresh ids (e.g., `ctx-00001`) and initialize `helpful=0 harmful=0`.

1) Grow-and-Refine
- Deduplicate within each section of PLAYBOOK.md after updates:
  - Normalize (lowercase, trim punctuation); compute similarity (e.g., `difflib`-style ratio or token Jaccard). Merge when similarity > 0.9.
  - On merge: keep older id; sum helpful/harmful counters; keep clearer content.
- If playbook grows too large, lazily prune oldest bullets with low (helpful−harmful) score.

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