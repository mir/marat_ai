---
description: Create implementation plan
argument-hint: <folder-with-specs>
allowed-tools: Grep, Bash(grep:*), Glob, Bash(glob:*), Bash(find:*), Bash(ls:*), Bash(tree:*), WebSearch, mcp__deepwiki__read_wiki_structure, mcp__deepwiki__read_wiki_contents, mcp__deepwiki__ask_question, Write(docs/*:*), Read
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

# [Feature Name]
The original idea reformulated in an easy to understand, clear, and consise way.

## Architectural plan
- How the existing features will be reused (if any)
- Which components will be added to the existing architecture (if any)
- Which components will be removed from the existing architecture (if any)
- Any other changes to the architecture (e.g., refactoring, major feature additions)

3 sentences max for each point in the architectural plan (less is better)

### Frontend (if any changes required)
Mermaid diagram of connected components

### Backend (if any changes required)
Mermaid diagram of connected components

### Database (if any changes required)
Mermaid diagram of tables and relations

## Data flow plan
Full Mermaid sequence diagram

### User story 1 data flow.
- text description of the step of the data flow
  - file reference
  - minimal code snippet with function signature
  - state changes (if any)
- text description of the step of the data flow
  - file reference
  - minimal code snippet with function signature
  - state changes (if any)

[repeat for other user stories]

## Implementation Tasks

- [ ] Task 1: [short name].
  - Details: [Text description of a specific implementation details]
  - File paths: [file.ts:10-20](path/to/file.ts#L10-L20)
  - Libraries docs: [snippet from the library docs, relevant to the task]  
  - Where in architectural diagram it should be
  - Where in data flow it should be
  - Testing strategy (optional):
    - Test scenario
    - How to invoke a command to run tests using AGENTS.md or CLAUDE.md

[repeat for other task, no more than 6 tasks]

# Summary
Which tasks can be run in parallel

```
