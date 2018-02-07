# Changes From Spec

From what I read in the spec, these are the decisions I made that deviate from it, along with the reasoning behind it.

1. *Admin Invitation Link*: This was because I've used this pattern before as a way to keep admin accounts secure, and by the time I realized I had made this assumption I had long ago built it.

2. *No graphs on Air Conditioner Show page*: This was merely a matter of time. This was one of the final features to be implemented, and while I thought it important, combined with deployment it was too much to get in under time.

3. *No ability to filter status reports by Today/This Week/This Month/This Year*: At the moment, we show the last 120 of them(without downtime, two hours), with no ability to filter. This would be trivial to add but once again would push the time.
