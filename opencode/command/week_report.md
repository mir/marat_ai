---
description: "Prepare weekly managment report"
agent: build
---

1. Prepare a report of the changes made last week in the following format:
<report format>
## <project name>
### This week
- Short sentence describing  change
- Short sentence describing  change
...
<report format>

2. Propose to post that to slack but do not perform it
curl -X POST -H 'Content-type: application/json' \
  --data '{
    "weekly_report": "<report>",
  }' \
  <hook url, e.g. https://hooks.slack.com/triggers/... />
