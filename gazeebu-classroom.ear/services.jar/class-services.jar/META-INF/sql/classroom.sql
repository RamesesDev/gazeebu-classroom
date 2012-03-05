[members]
 select a.userid as objid,a.usertype,a.state 
 from ( 
 select cs.userid, cs.usertype as usertype, cs.state, IF( cs.usertype = 'teacher', 0, 1 ) as sortorder 
 from class_membership cs  
 where cs.classid = $P{classid} ) a 
 order by a.sortorder
 
[find-member]
 select * from class_membership where classid=$P{classid} and userid=$P{userid}
 
[remove-member]
delete from class_membership where classid=$P{classid} and userid=$P{userid}

[remove-member-activities]
 delete
 from activity_grade
 where studentid = $P{userid} and 
 activityid in (select objid from activity where classid = $P{classid});