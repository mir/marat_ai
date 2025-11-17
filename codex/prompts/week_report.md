---
description: Prepare weekly management report
---

1. Prepare a report of the changes made last week in the following format:
<report format>
## <project name>
### This week
- Short sentence describing  change
- Short sentence describing  change
...
<report format>

2. If the message is visible to the end user, mark it with an heart emoji. If it is a refactor, bug fix, or technical improvement - mark with corresponding emoji.

3. Propose to post that to slack but do not perform it
curl -X POST -H 'Content-type: application/json' \
  --data '{
    "weekly_report": "<report>",
  }' \
  <hook url, e.g. https://hooks.slack.com/triggers/... />