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

# Requirements
   - Use the `- [ ]` for the tasks and subtasks
   - Keep only necessary tasks
   - Add references to key files, specs, and docs
   - Do not estimate time to implement
   - Avoid things that are nice to have, but not necessary
   - Avoid extra functionality
   - **Each subtask MUST include implementation details:**
     - Relevant file links with line numbers: [file.ts:42-51](path/to/file.ts#L42-L51)
     - API signatures or interfaces to implement
     - Library documentation references if using external dependencies
     - Database schema details if modifying data structures
     - Configuration examples if changing settings
     - Integration testing plan for automated testing
     - Snippets from AGENTS.md, README.md, CLAUDE.md relevant to the task
     - Code snippets showing existing patterns to follow, only if it is absolutely necessary and text description is not enough

# Output Format
```markdown
# Implementation Plan: [Feature Name]

## Context
[Brief description of what needs to be implemented and why]

- [ ] Read AGENTS.md, CLAUDE.md, README.md if exists
- [ ] Check [existing implementation](path/to/file)

## Implementation Tasks

- [ ] Task 1: [Description]
  - Details: [Specific implementation details]
  - Files: [file.ts:10-20](path/to/file.ts#L10-L20)
  - Libraries to use: [could be empty]
  - Testing strategy (optional):
    - Test scenario
    - How to invoke a command to run a test from AGENTS.md or CLAUDE.md

...

## Verification

- [ ] Verify implementation matches specs
- [ ] Run integration tests
- [ ] Check all references in context work correctly
```
