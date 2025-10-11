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
   - Add only absolutely necessary code snippets from existing files and docs
   - Wrap up tasks in <parallel>...</parallel> tags whenever possible
   - Do not estimate time to implement
   - Avoid unit tests
   - Avoid things that are nice to have, but not necessary
   - Avoid extra functionality
   - **Each subtask MUST include implementation details:**
     - Relevant file links with line numbers: [file.ts:42-51](path/to/file.ts#L42-L51)
     - Code snippets showing existing patterns to follow, only if it is absolutely necessary and text description is not enough
     - API signatures or interfaces to implement
     - Library documentation references if using external dependencies
     - Database schema details if modifying data structures
     - Configuration examples if changing settings

# Output Format
```markdown
# Implementation Plan: [Feature Name]

## Context
[Brief description of what needs to be implemented and why]

## Prerequisites
- [ ] Read AGENTS.md, CLAUDE.md, README.md if exists
- [ ] Review [relevant spec](path/to/spec)
- [ ] Check [existing implementation](path/to/file)

## Implementation Tasks

<parallel>
- [ ] Task that can run in parallel with other tasks in this block
  - References: [file:42](path/to/file#L42), [docs](https://example.com/docs)
- [ ] Another independent task
  - References: [another-file](path/to/another-file), [spec](path/to/spec.md)
  - Implementation: Follow the pattern in [another-file:15-30](path/to/another-file#L15-L30)
</parallel>

- [ ] Sequential task that depends on previous tasks
  - References: [main-file:100](path/to/main-file#L100)
  - [ ] Subtask 1: Create interface
    - File: [types.ts](path/to/types.ts)
  - [ ] Subtask 2: Implement handler
    - File: [handlers.ts:50](path/to/handlers.ts#L50)
    - Add after existing handlers
    - Use dependency injection pattern from [handlers.ts:20-35](path/to/handlers.ts#L20-L35)

<parallel>
- [ ] Another set of parallel tasks
  - References: [component](path/to/component)
  - Update component props interface at [component:10-15](path/to/component#L10-L15)
- [ ] Can be executed simultaneously
  - References: [utils](path/to/utils)
  - Add utility function following naming convention in [utils:5-8](path/to/utils#L5-L8)
</parallel>

## Testing
- [ ] Integration tests
- [ ] Manual testing checklist
```