[list]
select a.*, g.colorcode from activity a 
inner join grading_criteria g on g.objid=a.criteriaid 
inner join class_term c on c.objid=a.termid 
left join grading_category gc on gc.objid=a.categoryid 
where a.classid=$P{classid} order by c.fromdate, a.activitydate 

[results-byclass]
select r.* from activity_grade r 
inner join activity e on r.activityid=e.objid  
where e.classid=$P{classid} 


[results-byactivity]
select * from activity_grade r where r.activityid = $P{activityid}
