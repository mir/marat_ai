---
description: Prepare minimal necessary documentation for a user defined feature
agent: build
---

# Task
- Ask user to point to the folder or files necessary to make a plan, such as:
  - Main idea
  - User stories
  - Relevant files
  - Libraries
  - Web links
  - Code snippets
  - Database tables
  - Additional data
- Create a single .md file with minimal implementation plan
- Run the plan-spec-reviewer agent to review the written plan.

# Requirements
   - Use the `- [ ]` for the tasks and subtasks
   - Keep only necessary tasks
   - Add references to key files, specs, and docs
   - Do not estimate time to implement
   - Avoid things that are nice to have, but not necessary
   - Avoid extra functionality
   - Code snippets should consider only signatures, not implementation details

# Output Format
```markdown

# TOC
...

# Implementation Plan: [Feature Name]
The original idea reformulated in an easy to understand, clear, and consise way.

## Architectural plan
### Frontend
Mermaid diagram
### Backend
Mermaid diagram

### text descrition of the architecure

## Data flow plan
general dataflow mermaid diagram

### User story 1 data flow.
- text description of the step of the data flow
  - file reference
  - minimal code snippet 8 lines max
- text description of the step of the data flow
  - file reference
  - minimal code snippet 8 lines max

[repeat for other user stories]

## Implementation Tasks

- [ ] Task 1: [short name].
  - Details: [Text description of a specific implementation details]
  - File paths: [file.ts:10-20](path/to/file.ts#L10-L20)
  - Libraries: [could be empty]
  - Relevant docs snippets
  - Where in architectural diagram it should be
  - Where in data flow it should be
  - Testing strategy (optional):
    - Test scenario
    - How to invoke a command to run tests using AGENTS.md or CLAUDE.md

[repeat for other tasks]

# Summary
Which tasks can be run in parallel

```
