---
firstname: ""
lastname: ""
title: ""
place: |
  [[]]
---

## Activities
```dataview
TABLE WITHOUT ID
  ("[[" + file.path + "|" + title + "]]") AS "Activity",
  place AS "Place",
  type AS "Type",
  (date + " - " + date-end) AS "Date",
  people AS "People"
WHERE contains(join(people),this.firstname) AND category = "activity"
```
