[activitylist]
select a.*,c.colorcode from activity a 
inner join grading_criteria c on a.criteriaid = c.objid 
where a.classid=$P{classid} order by a.activitydate

[activitylist-by-criteria]
select a.*,c.colorcode from activity a 
inner join grading_criteria c on a.criteriaid = c.objid 
where a.classid=$P{classid} order by c.title, a.activitydate 

[activitylist-byperiod]
select a.*,c.colorcode from activity a 
inner join grading_criteria c on a.criteriaid = c.objid 
where a.classid=$P{classid} and a.periodid=$P{periodid} order by a.activitydate 

[class-results]
select r.* from activity_grade r inner join activity e on r.activityid=e.objid where e.classid=$P{classid} 

[results-byactivity]
select * from activity_grade r where r.activityid = $P{activityid}

[student-results]
select r.* from activity_grade r 
inner join activity a on r.activityid=a.objid 
where a.classid=$P{classid} and r.studentid=$P{studentid} 
