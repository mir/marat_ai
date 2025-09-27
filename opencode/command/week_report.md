---
description: "Prepare weekly managment report"
agent: build
---

Prepare a report of the changes made last week in the following format:
<report format>
## <project name>
### This week
- Short sentence describing  change
- Short sentence describing  change
...
### Next week
- Plan how to improve the change
- Plan how to improve the change
...
- Next step from TODO
- Next step from TODO
...
- Next step from roadmap
...
<report format>

Review the next steps and remove those which are already done.

Then propose to post that to slack but do not perform it
curl -X POST -H 'Content-type: application/json' \
  --data '{
    "weekly_report": "<report>",
  }' \
  <hook url, e.g. https://hooks.slack.com/triggers/... />
