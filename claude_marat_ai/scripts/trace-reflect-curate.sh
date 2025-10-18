#!/bin/bash
# save input into trace for debugging
trace=$(cat)
# prepare trace directory and file names
trace_dir="${CLAUDE_PROJECT_DIR:-.}/.trace"
mkdir -p "$trace_dir"

timestamp="$(date +%Y%m%d_%H%M%S_%3N)"
trace_file_name="$trace_dir/TRACE_$timestamp.json"
reflection_file_name="$trace_dir/REFLECTION_$timestamp.md"
add_to_playbook_file_name="$trace_dir/ADD_TO_PLAYBOOK_$timestamp.md"
playbook_file_name="${CLAUDE_PROJECT_DIR:-.}/PLAYBOOK.md"

echo "$trace" | jq 'select(.hook_event_name == "PostToolUse") | {tool_name, tool_input, tool_response, description: .tool_input.description}' > "$trace_file_name"

# Run Claude Code with reflector agent on the trace file
claude -p "Analyze the trace file at $trace_file_name and create a reflection following your agent instructions." \
    --model haiku \
    --system-prompt "# Role
You are an expert implementation auditor. Analyze subtask outcomes from $trace_file_name files and extract concrete, reusable insights.

# Task
- Tag $playbook_file_name bullets (used in the subtask) as helpful/harmful/neutral
- Produce $reflection_file_name for the next agent to add NEW bullets to $playbook_file_name only.

# Inputs
- Subtask context and goal
- Reasoning trace and tool calls (from $trace_file_name)
- Bullets used from $playbook_file_name (ids and text)

# Output $reflection_file_name format
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

# Wait a moment for the reflection file to be written
sleep 1

# Check if reflection file was created
reflection_file=$(find "$trace_dir" -name "$reflection_file_name" -type f -print0 | xargs -0 ls -t | head -n 1)

if [ ! -f "$reflection_file" ]; then
    exit 0
fi

# Run curator agent on the reflection file
claude -p "Read the reflection file at $reflection_file and the current $playbook_file_name. Propose additions following your agent instructions." \
    --model haiku \
    --system-prompt "# Role
You curate a compact, high-signal playbook. Add NEW bullets only; avoid redundancy.

# Task
- Read the current $playbook_file_name, recent reflections ($reflection_file), and task context.
- Propose only ADD operations with section and content in $add_to_playbook_file_name to enhance $playbook_file_name.
- Keep bullets specific, reusable, and free of duplication.
- Apply only NEW, non-redundant bullets from $add_to_playbook_file_name to enhance $playbook_file_name into $playbook_file_name. Assign fresh ids (e.g., \`ctx-00001\`) and initialize \`helpful=0 harmful=0\`.
- Deduplicate within each section of $playbook_file_name after updates:
  - Normalize (lowercase, trim punctuation); compute similarity (e.g., \`difflib\`-style ratio or token Jaccard). Merge when similarity > 0.9.
  - On merge: keep older id; sum helpful/harmful counters; keep clearer content.
- If playbook grows too large, lazily prune oldest bullets with low (helpful−harmful) score.

# Input
- question context or subtask description
- current $playbook_file_name
- recent reflection $reflection_file

# Output $add_to_playbook_file_name to enhance $playbook_file_name format
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
- No regeneration of the entire $playbook_file_name only additions.
- Prefer 1–3 bullets per checkpoint to prevent drift.
- Sections: strategies_and_hard_rules, apis_to_use_for_specific_information, verification_checklist, formulas_and_calculations, failures_and_resolutions.
- do not add summaries in the end
- Do not add anything that is not an entry with format specified above
- Do not add any suggestions in the end
- Produce only entries specified above, nothing else." \
    --allowed-tools "Read,Write,Edit,Bash,Grep,Glob" \
    --permission-mode acceptEdits

# Return success
exit 0
