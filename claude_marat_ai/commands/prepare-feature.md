---
description: Prepare comprehensive documentation for a user defined feature
argument-hint: <path-to-feature.md>
---

You are preparing documentation for a new feature implementation.

The user has created a feature description in a markdown file and will provide the file path as an argument.
If the .md file is not mentioned, ask user to create one.

1. Read the feature description file from $ARGUMENTS path.

2. Reformulate the user's feature request based on the file contents in a concise structured way to ensure which feature should be planned.
Output that for confirmation.

3. Execute the following steps in parallel using subagents and ask each subagent to write results into .md file under the docs/<feature-name> folder:
<parallel tasks>
  **Project Search Analysis** (use project-search subagent to find relevant files)
  **Web Research** (use web-research subagent to find relevant info from the web)
  **Specification Creation** (use spec subagent to create business user-experience based spec)
</parallel tasks>

4. Check that all parallel tasks generated corresponding .md files. Restart the tasks that failed.

5. Create a single .md file with implementation plan in the form of - [ ] tasks and subtasks. Follow the rules:
  - Do not estimate time to implement
  - Add references to key files, specs, and docs
  - Wrap up in <parallel>...</parallel> tags whenever possible
