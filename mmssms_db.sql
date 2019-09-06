SELECT
datetime(sms.date/1000,'UNIXEPOCH') AS "Time Stamp",
sms.address as "Telephone Number",
sms._id as "Message Sequence #",
sms.body As "Message Body",
CASE
WHEN addr.type = 151 Then " TO"
WHEN addr.type = 150 Then "Subject"
When addr.type = 137 then "From"
When addr.type = 130 then "CC"
WHEN addr.type = 129 then "BCC"
End as "Message meta type",
CASE
When sms.seen = 0 Then "Not Seen"
When sms.seen = 1 Then "Has Been Seen"
End as "Seen Status ",
CASE
When sms.read = 0 Then "Has Not Been Read"
when sms.read = 1 Then "Has Been Read"
End AS "Read Status",
CASE
When sms.status = -1 Then "N/A"
When sms.status = 0 Then "Complete"
When sms.status = 64 Then "Pending"
When sms.status = 128 Then "Failed"
End as "Message Delivery Status",
CASE
When threads.type = 1 Then "Inbox"
When threads.type = 2 then "Sent"
When threads.type = 3 Then "Draft"
When threads.type = 4 then "Outbox"
When threads.type = 5 then "failed"
When threads.type = 6 then "Qued"
End As "Message Send Status",
CASE
When threads.has_attachment = 0 Then " No Associated File"
When threads.has_attachment = 1 Then "Associated File"
End as "Message Has Files"
FROM sms
left join threads on threads._id = sms._id
left join addr on addr._id = sms._id
order by sms.date



