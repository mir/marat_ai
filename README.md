marat_ai
========

Reusable prompts, command templates, and helper scripts that keep Marat's
multi-agent coding assistants in sync. The repository centralizes the
instructions used by Claude, the Codex CLI, and OpenCode so they can be edited
once and re-used across tools.

Repository Layout
-----------------
- `claude_marat_ai/` – source-of-truth prompt library for Claude, organised into
  `agents/` and `commands/` with YAML front matter that captures metadata.
- `opencode/` – OpenCode-compatible copies of the same prompts (folder names are
  singular and formatting matches OpenCode's expectations); also contains
  `opencode.json` with local MCP and formatter settings.
- `codex/` – prompt set consumed by the Codex CLI (currently lives under
  `codex/prompts/`).
- `transfer_from_claude.py` – utility that copies Markdown from
  `claude_marat_ai/` to `opencode/`, stripping or reusing front matter as needed.
- `sync_codex.sh` / `sync_opencode.sh` – helper scripts that push the local
  versions of prompts into each tool's configuration directory.

Daily Workflow
--------------
1. Edit or add prompts inside `claude_marat_ai/` first so metadata stays
   consistent across platforms.
2. Run `./transfer_from_claude.py` (requires [uv](https://github.com/astral-sh/uv))
   to refresh the OpenCode copies while keeping any OpenCode-specific preamble.
3. Use the sync scripts when you are ready to try the prompts locally:

   ```bash
   ./sync_codex.sh       # copies codex/ → ~/.codex/
   ./sync_opencode.sh    # copies opencode/ → ~/.config/opencode/
   ```

   Both scripts create missing directories and replace existing files so you can
   rerun them safely after every edit.

Adding or Updating Prompts
--------------------------
- Keep YAML front matter at the top of each Markdown file; Codex ignores it, but
  Claude and OpenCode rely on the metadata.
- Prefer short, action-oriented descriptions and keep output format sections in
  Markdown so they render cleanly in every client.
- When creating a new prompt for Codex, copy the Claude version and adjust only
  the instructions that differ; the sync scripts do not transform content.
- Confirm any Mermaid diagrams render by pasting them into your client before
  shipping changes.

Command Reference
-----------------
- **`claude_marat_ai/commands/commit.md`** – user-only auto-commit flow. Capture
  outstanding changes, branch off `master` when needed, stage, commit with a
  concise message, push, and prompt the user to file a merge request.
- **`claude_marat_ai/commands/plan.md`** – deep implementation planner. Collects
  inputs, drafts a markdown plan with architecture/data-flow diagrams, task
  checklist, and then invokes the plan-spec-reviewer agent.
- **`claude_marat_ai/commands/prepare-feature.md`** – orchestration command that
  reforms a feature request, then spawns `project-search`, `web-research`, and
  `spec` agents in parallel and enforces numbered outputs under `docs/<feature>/`.
- **`claude_marat_ai/commands/explain-feature.md`** – documentation generator for
  a specific feature. Produces overview, sequence and flow diagrams, and a
  component-by-component walkthrough with file references and state changes.
- **`claude_marat_ai/commands/week_report.md`** – weekly status writer. Summaries
  recent work per project and prepares (but does not send) a Slack payload with
  the formatted report.

Agent Reference
---------------
- **`claude_marat_ai/agents/project-search.md`** – scans the codebase for
  relevant files, outputs references, lightweight snippets, diagrams, and a
  trimmed summary in `docs/`.
- **`claude_marat_ai/agents/spec.md`** – business-facing specification writer
  that distills user stories, functional requirements, edge cases, and a minimal
  end-to-end test plan without touching implementation details.
- **`claude_marat_ai/agents/web-research.md`** – external research assistant that
  prioritizes credible sources (forums, docs, DeepWiki) and records pros/cons and
  recommendations inside `docs/`.
- **`claude_marat_ai/agents/plan-spec-reviewer.md`** – reviewer that compares an
  implementation plan against a specification, logs critical gaps, and calculates
  coverage metrics in a standalone markdown report.

Troubleshooting
---------------
- If OpenCode metadata disappears after a transfer, verify the target file
  already contains the desired front matter; the transfer script preserves it.
- When new dependencies are needed for the Python script, update the inline
  `uv` metadata block inside `transfer_from_claude.py`.
- Keep an eye on trailing commas in JSON files such as
  `opencode/opencode.json`; OpenCode validation may be stricter than local
  tooling.
