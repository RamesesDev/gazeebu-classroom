[criterialist]
select * from grading_criteria where classid=$P{classid} order by indexno

[subcriteria]
select * from grading_subcriteria where criteriaid=$P{criteriaid}

[periods]
select * from grading_period where classid=$P{classid} order by fromdate

[eqs]
select * from grading_eq where classid=$P{classid} order by indexno

[remove-categories]
delete from grading_subcriteria where criteriaid=$P{criteriaid}

[update-subentry-count]
update grading_criteria set subentries=$P{subentrycount} where objid=$P{criteriaid}

