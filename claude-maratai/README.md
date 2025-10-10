# Claude MaratAI Plugin

AI-powered development workflow automation plugin for Claude Code. Streamline your development process with specialized agents and smart commands.

## Features

### 🤖 Specialized Agents

#### `/project-search`
Search your codebase for relevant files and components with intelligent analysis.
- Provides file paths and line numbers for easy navigation
- Shows code snippets with context
- Creates mermaid diagrams to visualize module connections
- Generates summary documentation in docs/ folder
- Model: Claude Sonnet

#### `/review`
Comprehensive code review of uncommitted changes.
- Analyzes git diff and status
- Identifies potential bugs and edge cases
- Suggests improvements for code compactness
- Verifies library usage with deepwiki MCP integration
- Generates review summaries
- Model: Claude Sonnet

#### `/spec`
Create detailed feature specifications with user stories and test plans.
- Three versions of specifications focusing on key aspects
- Detailed user stories in standard format
- Functional and non-functional requirements
- Edge case identification
- End-to-end testing plans for QA
- Outputs to docs/ folder
- Model: Claude Sonnet

#### `/web-research`
Research web resources for technical solutions and libraries.
- Web search integration
- GitHub repository search via deepwiki MCP
- Library and framework recommendations
- Compatibility analysis
- Pros/cons comparison
- Documentation in docs/ folder
- Model: Claude Sonnet

### ⚡ Smart Commands

#### `/commit`
Auto-commit with intelligent branching.
- Detects if on master/main branch
- Creates descriptive feature branch automatically
- Stages and commits changes with smart commit messages
- Pushes branch to remote
- Suggests creating merge request via glab

#### `/prepare-feature`
Comprehensive feature preparation workflow.
- Reformulates user request for clarity
- Runs parallel analysis:
  - Project search for existing patterns
  - Web research for best practices
  - Specification creation
- Generates implementation plan with task breakdown
- Creates documentation in docs/<feature-name>/

#### `/week_report`
Generate weekly management reports from git history.
- Analyzes commits from the past week
- Formats changes in management-friendly format
- Suggests posting to Slack (provides curl command)

## MCP Integration

This plugin automatically configures the **DeepWiki MCP server** for enhanced GitHub and documentation search capabilities.

### DeepWiki MCP Features

The DeepWiki MCP provides three powerful tools that enhance the agents' capabilities:

- **`read_wiki_structure`**: Get a list of documentation topics for any GitHub repository
- **`read_wiki_contents`**: View comprehensive documentation about a GitHub repository
- **`ask_question`**: Ask specific questions about any GitHub repository

### Configuration

The plugin includes a `.mcp.json` configuration file that automatically sets up the DeepWiki MCP server when the plugin is installed:

```json
{
  "mcpServers": {
    "deepwiki": {
      "type": "remote",
      "url": "https://mcp.deepwiki.com/sse",
      "enabled": true
    }
  }
}
```

**Note**: The DeepWiki MCP is a free, remote service that requires no authentication. After installing the plugin, restart Claude Code to activate the MCP server.

## Installation

1. Clone or download this plugin to your local machine
2. In Claude Code, add the plugin via the marketplace or local installation
3. Restart Claude Code to activate the DeepWiki MCP server
4. The plugin is ready to use with all agents and commands available

## Usage Examples

```bash
# Prepare comprehensive feature documentation
/prepare-feature user notification system

# Commit changes with smart branching
/commit

# Review current changes
/review

# Generate weekly report
/week_report
```

## Requirements

- Claude Code
- Git (for commit and week_report commands)
- Optional: glab CLI tool (for GitLab merge requests)
- Optional: Slack webhook (for week_report posting)

## Version

1.0.0

## Author

maratyuldashev
