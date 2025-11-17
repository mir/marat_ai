---
description: Prepare minimal necessary documentation for a user defined feature
argument-hint: <path-to-feature.md>
allowed-tools: Grep, Bash(grep:*), Glob, Bash(glob:*), Bash(find:*), Bash(ls:*), Bash(tree:*), WebSearch, mcp__deepwiki__read_wiki_structure, mcp__deepwiki__read_wiki_contents, mcp__deepwiki__ask_question, Write(docs/*:*), Read
---

# Task
You are preparing documentation for a new feature implementation.

# Instructions
1. The user has created a feature description in a markdown file and will provide the file path as an argument. If the argument is empty look at docs/ folder for files or subforlders with files that looks like ideas for new features, and then give a user enumerate list of file candidates to choose from.
2. Read the feature description file.
3. Reformulate the user's feature request based on the file contents in a concise structured way to ensure which feature should be planned.
Output that for confirmation.
4. Execute the following steps in parallel using subagents and ask each subagent to write results into .md file under the docs/<feature-name> folder:
  <parallel tasks>
    **Project Search Analysis** (use project-search subagent to find relevant files)
    **Web Research** (use web-research subagent to find relevant info from the web)
    **Product Spec Creation** (use product-spec subagent to create business user-experience based spec)
  </parallel tasks>
  When formulating tasks to agents do not ask agents to create implementation plan.
5. Check that all parallel tasks generated corresponding .md files. Restart the tasks that failed.
6. Rename the files to have prefix related to step number, e.g.: 1_idea.md, 2_project_research.md, 3_web_research.md, 4_specs.md
