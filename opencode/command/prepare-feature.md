---
description: Prepare minimal necessary documentation for a user defined feature
agent: build
---

# Task
You are preparing documentation for a new feature implementation.

# Instructions
0. The user has created a feature description in a markdown file and will provide the file path as an argument.
If the .md file is not mentioned, ask user to create one in docs/<feature-name>/0_idea.md
1. Read the feature description file.
2. Reformulate the user's feature request based on the file contents in a concise structured way to ensure which feature should be planned.
Output that for confirmation.
3. Execute the following steps in parallel using subagents and ask each subagent to write results into .md file under the docs/<feature-name> folder:
<parallel tasks>
  **Project Search Analysis** (use project-search subagent to find relevant files)
  **Web Research** (use web-research subagent to find relevant info from the web)
  **Specification Creation** (use spec subagent to create business user-experience based spec)
</parallel tasks>
When formulating tasks to agents do not ask agents to create implementation plan.
4. Check that all parallel tasks generated corresponding .md files. Restart the tasks that failed.
5. Rename the files to have prefix related to step number, e.g.: 1_idea.md, 2_project_research.md, 3_web_research.md, 4_specs.md
