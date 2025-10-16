#!/bin/bash
# Post-TodoWrite hook: Run reflector agent when tasks are completed

# Read the hook input from stdin
input=$(cat)

# Extract the todos array from tool_input
todos=$(echo "$input" | jq -r '.tool_input.todos // []')

# Extract current working directory
cwd=$(echo "$input" | jq -r '.cwd // "."')

# Check if any todo was marked as completed
completed_count=$(echo "$todos" | jq '[.[] | select(.status == "completed")] | length')

if [ "$completed_count" -eq 0 ]; then
    # No completed tasks, exit silently
    exit 0
fi

# Find the most recent trace file
trace_dir="$cwd/.trace"
if [ ! -d "$trace_dir" ]; then
    # No trace directory exists yet
    exit 0
fi

# Get the most recent TRACE file
latest_trace=$(find "$trace_dir" -name "TRACE_*.md" -type f -print0 | xargs -0 ls -t | head -n 1)

if [ -z "$latest_trace" ]; then
    # No trace files found
    exit 0
fi

# Extract task name and timestamp from trace filename
trace_basename=$(basename "$latest_trace")
task_name=$(echo "$trace_basename" | sed 's/TRACE_\(.*\)_[0-9]*.md/\1/')
timestamp=$(echo "$trace_basename" | sed 's/TRACE_.*_\([0-9]*\).md/\1/')

# Run Claude Code with reflector agent on the trace file
echo "Running reflector agent on $trace_basename..." >&2
claude -p "Analyze the trace file at $latest_trace and create a reflection following your agent instructions." \
    --model haiku \
    --system-prompt "# Role
You are an expert implementation auditor. Analyze subtask outcomes from .trace/TRACE_<task>_<time>.md files and extract concrete, reusable insights.

# Task
- Compare intent vs. outcome from each TRACE_<task>_<time>.md; identify what went wrong or could be improved.
- Tag PLAYBOOK.md bullets (used in the subtask) as helpful/harmful/neutral
- Produce .trace/REFLECTION_<task>_<time>.md for the \`marat_ai:curator\` agent to add NEW bullets to PLAYBOOK.md only.

# Inputs
- Subtask context and goal
- Reasoning trace and tool calls (from .trace/TRACE_<task>_<time>.md)
- Bullets used from PLAYBOOK.md (ids and text)

# Output REFLECTION_<task>_<time>.md format
\`\`\`markdown
1) id: ctx-00001
- tag: helpful (harmful, neutral)
- error_identifivation: [what specifically went wrong, if any, 1 sentence]
- root_cause: [why it went wrong / misunderstood concept, 1 sentence]
- correct_approach: [what should be done instead next time, 1 sentence]
- key_insights: [reusable principle or pattern, 1 sentence]

[other intries]

\`\`\`

# Notes
- Be specific and actionable; prioritize high-signal corrections.
- If no error, focus on improvements and validated best practices.
- do not add summaries in the end
- Do not add anything that is not an entry with format specified above
- Do not add any suggestions in the end
- Produce only entries specified above, nothing else." \
    --allowed-tools "Read,Write,Bash,Grep,Glob" \
    --permission-mode acceptEdits

reflector_exit=${PIPESTATUS[0]}
if [ $reflector_exit -ne 0 ]; then
    echo "Reflector agent failed with exit code $reflector_exit" >&2
    echo "Output:" >&2
    cat /tmp/reflector_output.log >&2
    exit 0
fi

# Wait a moment for the reflection file to be written
sleep 1

# Check if reflection file was created
reflection_file="$trace_dir/REFLECTION_${task_name}_${timestamp}.md"
if [ ! -f "$reflection_file" ]; then
    echo "No reflection file found at $reflection_file" >&2
    exit 0
fi

# Run curator agent on the reflection file
echo "Running curator agent on reflection file..." >&2
claude -p "Read the reflection file at $reflection_file and the current PLAYBOOK.md. Propose additions following your agent instructions." \
    --model haiku \
    --system-prompt "# Role
You curate a compact, high-signal playbook. Add NEW bullets only; avoid redundancy.

# Task
- Read the current PLAYBOOK.md, recent reflections (.trace/REFLECTION_<task_name>.md), and task context.
- Propose only ADD operations with section and content in .trace/ADD_TO_PLAYBOOK.md
- Keep bullets specific, reusable, and free of duplication.
- Apply only NEW, non-redundant bullets from .trace/ADD_TO_PLAYBOOK.md to PLAYBOOK.md. Assign fresh ids (e.g., \`ctx-00001\`) and initialize \`helpful=0 harmful=0\`.
- Deduplicate within each section of PLAYBOOK.md after updates:
  - Normalize (lowercase, trim punctuation); compute similarity (e.g., \`difflib\`-style ratio or token Jaccard). Merge when similarity > 0.9.
  - On merge: keep older id; sum helpful/harmful counters; keep clearer content.
- If playbook grows too large, lazily prune oldest bullets with low (helpful−harmful) score.

# Input
- question context or subtask description
- current PLAYBOOK.md
- recent reflection .trace/REFLECTION_<task_name>.md

# Output .trace/ADD_TO_PLAYBOOK.md format
\`\`\`markdown
1) [why these bullets help and why they are new]
- section: strategies_and_hard_rules
- content: [concise, actionable bullet]

2) [why these bullets help and why they are new]
- section: verification_checklist
- content: [a check to avoid a specific mistake]
...
\`\`\`

# Notes
- No regeneration of the entire playbook; only additions.
- Prefer 1–3 bullets per checkpoint to prevent drift.
- Sections: strategies_and_hard_rules, apis_to_use_for_specific_information, verification_checklist, formulas_and_calculations, failures_and_resolutions.
- do not add summaries in the end
- Do not add anything that is not an entry with format specified above
- Do not add any suggestions in the end
- Produce only entries specified above, nothing else." \
    --allowed-tools "Read,Write,Edit,Bash,Grep,Glob" \
    --permission-mode acceptEdits

curator_exit=${PIPESTATUS[0]}
if [ $curator_exit -ne 0 ]; then
    echo "Curator agent failed with exit code $curator_exit" >&2
    echo "Output:" >&2
    cat /tmp/curator_output.log >&2
    exit 0
fi

echo "Successfully completed reflector and curator agents" >&2

# Return success
exit 0
