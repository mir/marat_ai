# Marat AI

Development workflow files

## Getting Started

### Prerequisites

- Install https://opencode.ai
- Copy agent/*.md and command/*.md to your project's .opencode folder or to ~/.config/opencode/

## Commands and Agents

**Agents** (agent/*.md): Specialized sub-agents for tasks like codebase search (project-search), code review (review), spec creation (spec), and web research (web-research). Launch via Task tool with `subagent_type`.

**Commands** (command/*.md): Custom slash commands for workflows, e.g., /commit (auto-branch/commit/push), /prepare-feature (docs via parallel agents), /span (parallel research tasks), /week_report (git-based reports). Use via `/command-name`.

**MCPs** (opencode.json): deepwiki for GitHub repo/docs search (enabled).

## Example Workflow Story

Imagine implementing a new user authentication feature:

1. **/prepare-feature**: Run `/prepare-feature "Add OAuth login"`. This reformulates the request, launches parallel agents: **project-search** (finds existing auth files like `src/auth.js:45`), **web-research** (researches OAuth libs via deepwiki MCP, e.g., querying GitHub for "passport.js examples"), and **spec** (creates user stories, edge cases, and testing plan in `docs/auth/spec.md`).

2. **/span**: Use `/span "Research OAuth integration patterns"` to decompose into parallel tasks, launching headless agents to search codebase and web concurrently, outputting to `docs/dev/span-results.md`.

3. Implement based on docs, then **review**: Launch **review** agent to analyze uncommitted changes for bugs/optimizations, checking libs via deepwiki.

4. **/commit**: Run `/commit` to branch, stage, commit ("Add OAuth support"), and push, proposing an MR.

5. At week's end, **/week_report**: Generates a report summarizing changes, next steps from TODO/roadmap, and proposes Slack post.

This workflow streamlines feature dev from research to deployment.

## License

[MIT](LICENSE)
