# marat_ai

Personal automation and configuration for running OpenCode-style agents and commands. The repo keeps two synchronized views of the same content:

- `claude_marat_ai/` — authoring source with YAML frontmatter for commands and agents
- `opencode/` — runtime configuration consumed by OpenCode (frontmatter stripped, paths normalized)

Helper scripts keep these folders in sync and copy runtime config into `~/.config/opencode`.

## Overview

- Commands live under `*/command/*.md` and define task behavior (e.g., plan, prepare-feature, commit, week_report).
- Agents live under `*/agent/*.md` and provide specialized roles (e.g., spec authoring, plan/spec review, project search, web research, code review).
- `opencode/opencode.json` configures formatters and MCP tools (e.g., DeepWiki MCP) used by OpenCode.
- `transfer_from_claude.py` maps `claude_marat_ai/{agents,commands}` → `opencode/{agent,command}` and removes YAML frontmatter while preserving any existing target preamble.
- `sync_opencode.sh` copies everything in `opencode/` to `~/.config/opencode/` so your OpenCode runner can pick it up.

## Quick Start

1. Ensure prerequisites are installed:
   - Bash (for the sync script)
   - Python 3.12+
   - `uv` (for the Python script shebang: `uv run --script`)
   - Optional: `ruff` via `uvx` (used by formatters in `opencode.json`)
2. Sync authored files into the OpenCode view:
   - `./transfer_from_claude.py`
3. Copy OpenCode config into your user config directory:
   - `./sync_opencode.sh`
4. Use your OpenCode runner/editor integration; it should discover commands/agents from `~/.config/opencode/`.

## Repository Structure

```
opencode/
  command/
    commit.md
    plan.md
    prepare-feature.md
    week_report.md
  agent/
    plan-spec-reviewer.md
    project-search.md
    review.md
    spec.md
    web-research.md
  opencode.json

claude_marat_ai/
  commands/
    commit.md
    plan.md
    prepare-feature.md
    week_report.md
  agents/
    plan-spec-reviewer.md
    project-search.md
    spec.md
    web-research.md

transfer_from_claude.py
sync_opencode.sh
```

## Commands (opencode/command)

- `prepare-feature.md` — Prepare minimal documentation for a new feature; orchestrates project search, web research, and spec creation as parallel subagents, then organizes outputs under `docs/<feature-name>/`.
- `plan.md` — Create a minimal implementation plan with only necessary tasks and concrete implementation details (file refs, interfaces, test strategy, etc.).
- `commit.md` — Auto-commit with smart branching: stages changes, branches off `master` when needed, commits, and proposes opening an MR.
- `week_report.md` — Draft a concise weekly management report and propose posting it to Slack (dry-run).

## Agents (opencode/agent)

- `spec.md` — Business-first minimal specifications: user stories, functional requirements, edge cases, and minimal end-to-end testing plan.
- `plan-spec-reviewer.md` — Compares an implementation plan against the spec; reports gaps in user stories, requirements, edge cases, testing, and data flow.
- `project-search.md` — Scans the codebase; outputs compact references with file:line links and minimal diagrams.
- `web-research.md` — Research assistant; gathers focused external references and options with pros/cons.
- `review.md` — Lightweight code review guidance over current uncommitted changes.

## Configuration (opencode/opencode.json)

- MCP: enables `deepwiki` remote MCP server for research/search.
- Formatters: integrates `ruff` via `uvx` for `check --fix` and `format` on Python files (.py).

If you rely on formatters, ensure `uv` is installed and `uvx ruff` is available in your PATH.

## Typical Workflow

1. Author or edit sources in `claude_marat_ai/agents` and `claude_marat_ai/commands`.
2. Run `./transfer_from_claude.py` to propagate changes to `opencode/` while removing authoring frontmatter.
3. Run `./sync_opencode.sh` to update `~/.config/opencode/` with the latest commands, agents, and config.
4. Invoke commands from your OpenCode runner or editor integration.

Notes:
- The transfer script preserves an existing preamble in target files if present.
- Folder names are normalized: `agents → agent`, `commands → command`.

## Troubleshooting

- Command/agent not showing up:
  - Re-run `./transfer_from_claude.py` and then `./sync_opencode.sh`
  - Confirm files exist under `~/.config/opencode/`
- Formatter errors:
  - Ensure `uv` is installed; run `uvx ruff --version` to verify availability
- DeepWiki MCP connectivity:
  - Make sure your environment/network allows connecting to the configured SSE endpoint

## License

No license file is provided in this repository. Add one if you plan to share or open source this project.
