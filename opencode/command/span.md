---
description: "Analyze user request and execute parallel research tasks"
allowed-tools: Write(*), Grep(*), Glob(*), Read(*), Bash(*), WebSearch(*), WebFetch(*), mcp__deepwiki__*
---

You are tasked with analyzing the user's research request and dividing it into parallelizable tasks that can be executed concurrently by multiple Claude Code processes running in headless mode. Follow these steps:

## 1. Request Analysis
Analyze the user's request ($ARGUMENTS) to identify:
- Independent research areas (different folders, files, or code sections)
- Different types of information needed (documentation, code patterns, configurations)
- Separate documentation sources or external resources
- Different search keywords or patterns that don't overlap

## 2. Task Decomposition
Break down the request into 2-5 independent tasks, where each task:
- Has a clear, specific scope (e.g., "search backend/src for authentication logic")
- Can be executed without dependencies on other tasks
- Focuses on a distinct aspect of the research
- Has clear deliverables and expected outcomes

## 3. Parallel Execution Setup
For each identified task, create:
1. A detailed prompt file (`docs/dev/span-task-N.md`) containing:
   - The specific research question
   - Instructions to focus on relevant information only
   - Instructions to write findings to `docs/dev/span-task-N-result.md`
   - Clear scope and expected deliverables
   - The last line should specify which minimal set of tools that are allowed for running claude in the format:
  Read,Grep,Glob,Write
2. Launch parallel Claude Code processes in headless mode using bash

## 4. Bash Execution
Execute all tasks in parallel using background processes:
```bash
# Ensure docs/dev directory exists
mkdir -p docs/dev

# Launch parallel processes for each task file
for task_file in docs/dev/span-task-*.md; do
    opencode run "$(cat "$task_file")"
done

# Wait for all background processes to complete
wait
```

**Example task**
```
Search for the files and functions important for the implementation of the user request

# User request
<user request>

# Scope
Search only in the following patterns:
apps/backend/**/*.py

Write your findings to docs/dev/span-task-1-result.md with clear sections for each model found.

# Allowed tools
Read,Grep,Glob,Write
```
