---
description: Fix the mermaid syntax in .md file
---

Check that the following rules are satisfied and fix them otherwise for the file

# Mermaid hints

## General Rules
- **DO NOT use `<br>` or `<br/>` tags** in node labels - use natural text wrapping or simple separators like commas (`,`) or hyphens (`-`)
- **Avoid HTML entities in arrows**: Use literal arrow syntax (`->>`, `-->`) not HTML entities (`-&gt;&gt;`)
- **Wrap paths in quotes**: For file paths like `path/to/file`, use quotes: `["path/to/file"]`
- **No HTML formatting**: Keep labels simple and readable
- **Check that code blocks use three backticks** (not XML tags)
- **Don't prefix backticks with backslashes** in code blocks
- **Do not use numbered items** in diagrams - drop all the `1. `, `2. `, etc. since dot + space sequences don't render properly

## Sequence Diagrams
- **Message syntax**: Always use colon for messages: `Actor1->>Actor2: Message text`
- **Semicolons in text**: Replace with entity code `#59;` (e.g., `Message#59; details`)
- **Word "end"**: Capitalize: `END`

## Flowcharts
- **Node labels with quotes**: All node labels shoult be in double quotes `NodeID["Node -- /path label"]`
- **Word "end"**: Capitalize any letter: `End`, `END`
- **Leading 'o' or 'x'**: Add space or capitalize: `dev--- ops` or `dev---Ops`

## State Diagrams
- **State labels**: Use colon notation: `StateID: Description`, avoid any special symbols for labels, just plane alphanumeric characters and spaces
- **Transitions**: Use `-->` for arrows with optional labels: `State1-->State2: label`

## Gantt Charts
- **Task syntax**: Use colons to separate title from metadata: `Task title: metadata`
- **Dependencies**: Use `after taskID` or `until taskID` (v10.9.0+)

# Validation rules
- **Always validate** with `mmdc -i markdown_with_diagrams.md` to catch syntax errors
- Fix errors and validate again until no errors persist