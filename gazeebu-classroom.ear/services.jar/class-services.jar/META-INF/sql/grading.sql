[criterialist]
select * from grading_criteria where classid=$P{classid} order by indexno

[periods]
select * from grading_period where classid=$P{classid} order by fromdate

[eqs]
select * from grading_eq where classid=$P{classid} order by indexno

[clear-eqs]
delete from grading_eq where classid=$P{classid}
