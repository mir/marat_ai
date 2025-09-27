---
description: Prepare comprehensive documentation for a user defined feature
mode: command
---

You are preparing documentation for a new feature implementation.

1. Reformulate users request in a consise structured way to ensure which feature should be planned.

2. Execute the following steps in parallel using subagents:
<parallel tasks>
  **Project Search Analysis** (use project-search subagent):
  **Web Research** (use web-research subagent):
  **Specification Creation** (use spec subagent):
</parallel tasks>

3. Check that all parallel tasks generated corresponidng .md files. Restart the tasks that failed.

4. Move all created .md files in the docs/<feature-name>/ folder with bash command.

5. Create a single .md file with implementation plan in the form of - [ ] tasks and subtasks.
  - Do not estimate time to implement
  - Add references to key files, specs, and docs.
  - Wrap up in <parallel>...</parallel> tasks whenever appropriate
