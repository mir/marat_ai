# Marat AI

A comprehensive collection of development workflow tools for Claude Code and [OpenCode](https://opencode.ai), featuring specialized agents, custom commands, and MCP integrations to streamline your software development process.

## Overview

Marat AI provides a powerful toolkit that enhances Claude Code and OpenCode with:

- **Specialized Agents**: Autonomous sub-agents for complex tasks like codebase search, code review, specification creation, and web research
- **Custom Commands**: Slash commands for common workflows including auto-commit, feature documentation, and reporting
- **MCP Integrations**: Deep GitHub repository and documentation search capabilities
- **OpenCode Configurations**: Pre-configured settings optimized for development workflows

## Getting Started

### For Claude Code Users

Claude Code uses a plugin system. To install Marat AI directly from GitHub:

1. Install [Claude Code](https://claude.com/claude-code)
2. Start Claude Code and add the GitHub marketplace:
   ```
   /plugin marketplace add mir/marat_ai
   ```
3. Install the plugin:

For more information about Claude Code plugins, see the [plugins documentation](https://docs.claude.com/en/docs/claude-code/plugins).

### For OpenCode Users

OpenCode uses a simpler configuration approach:

1. Install [OpenCode](https://opencode.ai)
2. Copy the configuration files to your project:
   ```bash
   cp -r opencode/opencode.json /path/to/your/project/.opencode/
   cp -r agent/*.md command/*.md /path/to/your/project/.opencode/
   ```

   Or install globally:
   ```bash
   cp -r opencode/opencode.json agent/*.md command/*.md ~/.config/opencode/
   ```

For more information about OpenCode configuration, see the [OpenCode documentation](https://opencode.ai/docs).

### Quick Start

Once installed, you can immediately use any of the available commands or agents in your sessions.

## Features

### Agents

Agents are specialized sub-agents that handle complex, multi-step tasks autonomously. Launch them using the Task tool with the appropriate `subagent_type`:

- **project-search**: Search your codebase for relevant files and components
- **review**: Analyze code changes for bugs, optimizations, and best practices
- **spec**: Create comprehensive specifications with user stories and test plans
- **web-research**: Research topics using web search and documentation

### Commands

Custom slash commands provide quick access to common workflows:

- **/commit**: Automatically create branches, stage changes, commit with smart messages, and push
- **/prepare-feature**: Generate comprehensive feature documentation using parallel agents
- **/span**: Break down research tasks and execute them in parallel
- **/week_report**: Generate weekly reports based on git history and project status

### MCPs

Model Context Protocol integrations extend Claude Code and OpenCode capabilities:

- **deepwiki**: Search GitHub repositories and their documentation (see `opencode.json`)

### OpenCode Configuration

The `opencode/opencode.json` file contains pre-configured settings for OpenCode, including:

- MCP server configurations (deepwiki)
- Optimized settings for development workflows

For more information about OpenCode configuration, see the [OpenCode documentation](https://opencode.ai/docs).

## Example Workflow

Here's a complete workflow for implementing a new OAuth authentication feature:

### 1. Planning and Research

```
/prepare-feature "Add OAuth login support"
```

This command:
- Reformulates your request for clarity
- Launches **project-search** agent to find existing auth code (e.g., `src/auth.js:45`)
- Runs **web-research** agent to find OAuth libraries and best practices
- Uses **spec** agent to create user stories, edge cases, and testing plans
- Outputs comprehensive documentation to `docs/auth/spec.md`

### 2. Deep Research

```
/span "Research OAuth integration patterns"
```

This command:
- Decomposes the topic into focused research tasks
- Launches multiple agents in parallel to search codebase and web
- Aggregates findings into `docs/dev/span-results.md`

### 3. Implementation

Implement the feature based on the generated documentation and research.

### 4. Code Review

Launch the **review** agent to analyze your changes:
- Identifies potential bugs and security issues
- Suggests optimizations
- Checks library usage against best practices

### 5. Commit and Deploy

```
/commit
```

This command:
- Creates a feature branch
- Stages all changes
- Generates an intelligent commit message
- Pushes to remote
- Optionally creates a merge request

### 6. Weekly Reporting

```
/week_report
```

At the end of the week, generate a summary report:
- Analyzes git history for completed work
- Reviews TODO and roadmap files for next steps
- Proposes a formatted Slack update

## Project Structure

```
marat_ai/
├── claude_marat_ai/           # Claude Code plugin
│   ├── .claude-plugin/
│   │   └── plugin.json        # Plugin manifest
│   ├── agents/                # Specialized agent definitions
│   │   ├── project-search.md
│   │   ├── review.md
│   │   ├── spec.md
│   │   └── web-research.md
│   ├── commands/              # Custom slash commands
│   │   ├── commit.md
│   │   ├── prepare-feature.md
│   │   └── week_report.md
│   └── .mcp.json              # MCP configuration for plugin
├── opencode/                  # OpenCode configuration
│   └── opencode.json          # OpenCode settings and MCP config
└── .claude-plugin/
    └── marketplace.json       # Plugin marketplace manifest
```

## Best Practices

- Use **/prepare-feature** before starting major features to ensure comprehensive planning
- Run the **review** agent before committing significant changes
- Leverage **/span** for complex research tasks that benefit from parallel processing
- Use **/commit** for consistent, well-formatted commit messages
- Generate **/week_report** regularly to track progress and communicate updates

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve the workflow tools.

## License

[MIT](LICENSE)
