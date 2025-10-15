# marat_ai

AI-powered development workflow automation with specialized agents for project search, code review, specification creation, and web research.

## Overview

`marat_ai` is a plugin for Claude Code and OpenCode that provides intelligent development workflow automation through specialized AI agents and custom slash commands. It implements an ACE (Autonomous Cognitive Entity) framework with Generator-Reflector-Curator pattern for iterative improvement.

## Features

### Custom Slash Commands

- **`/marat_ai:prepare-feature <path>`** - Prepare minimal necessary documentation for a user-defined feature
  - Analyzes feature requirements
  - Performs parallel project search, web research, and spec creation
  - Generates structured documentation in `docs/<feature-name>/`

- **`/marat_ai:plan <folder>`** - Create implementation plan from specifications
  - Generates detailed implementation tasks with file references
  - Includes architectural and data flow plans
  - Adds testing strategies and library references

- **`/marat_ai:implement <path>`** - Implement plans using ACE-style adaptation
  - Uses PLAYBOOK.md for storing learned patterns and strategies
  - Follows Generator, Reflector, Curator cycle
  - Automatically learns from failures and successes
  - Generates trace logs for debugging

- **`/marat_ai:commit`** - Auto-commit with smart branching
  - Automatically creates feature branches from master
  - Generates descriptive commit messages
  - Proposes merge requests

- **`/marat_ai:week_report`** - Prepare weekly management report
  - Analyzes last week's changes
  - Formats report for Slack posting

### Specialized Agents

- **curator** - Proposes minimal delta updates to the PLAYBOOK
- **reflector** - Diagnoses implementation steps and extracts actionable insights
- **project-search** - Searches the current project for relevant files and components
- **spec** - Creates minimal specifications with user stories and test plans
- **web-research** - Researches the web for relevant information
- **review** - Reviews code changes

## Installation

### For Claude Code

The plugin is already configured in `.claude-plugin/marketplace.json`. Claude Code will automatically load it from the `claude_marat_ai/` directory.

### For OpenCode

1. Transfer files to OpenCode format:
   ```bash
   uv run transfer_from_claude.py
   ```

2. Sync to OpenCode config directory:
   ```bash
   ./sync_opencode.sh
   ```

## Development Workflow

### Typical Feature Development Flow

1. **Create feature idea**: Write a markdown file describing your feature in docs/<faeature-name> folder
2. **Prepare documentation**: `/marat_ai:prepare-feature docs/<faeature-name>/idea.md`
3. **Create implementation plan**: `/marat_ai:plan docs/<faeature-name>`
4. **Implement**: `/marat_ai:implement docs/<faeature-name>/5_implementation_plan.md`
5. **Commit**: `/marat_ai:commit`

### ACE Framework

The implementation command uses an ACE (Autonomous Cognitive Entity) framework:

1. **Generator Phase**: Implements subtasks using relevant PLAYBOOK patterns
2. **Reflector Phase**: Analyzes implementation, identifies errors and insights
3. **Curator Phase**: Updates PLAYBOOK with new learnings
4. **Grow-and-Refine**: Deduplicates and prunes PLAYBOOK entries

The PLAYBOOK.md maintains:
- `strategies_and_hard_rules` - Best practices and constraints
- `apis_to_use_for_specific_information` - API patterns
- `verification_checklist` - Testing and validation steps
- `formulas_and_calculations` - Algorithms and logic
- `failures_and_resolutions` - Known issues and solutions

Each bullet tracks `helpful_count` and `harmful_count` for relevance ranking.

## Scripts

### transfer_from_claude.py

Converts Claude Code plugin format to OpenCode format by:
- Removing YAML frontmatter from commands and agents
- Mapping folder names (agents�agent, commands�command)
- Preserving OpenCode preambles if they exist

### sync_opencode.sh

Syncs the `opencode/` directory to `~/.config/opencode/`:
- Creates target directories as needed
- Replaces existing files

## Requirements

- Python 3.12+ (for scripts)
- `uv` package manager
- Claude Code or OpenCode

## License

This project is for personal use.
