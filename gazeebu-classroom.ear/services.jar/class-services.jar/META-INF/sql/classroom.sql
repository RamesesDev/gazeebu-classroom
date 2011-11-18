[members]
 select a.objid,a.lastname,a.firstname,a.profile,a.usertype,a.state
 from( 
 select u.objid,u.lastname,u.firstname,u.profile,cs.usertype as usertype, cs.state,
	IF( cs.usertype = 'teacher', 0, 1 ) as sortorder 
 from userprofile u  
 inner join class_membership cs on cs.userid = u.objid  
 where cs.classid = $P{classid} ) a 
 order by a.sortorder, a.lastname, a.firstname
 
[find-member]
 select * from class_membership where classid=$P{classid} and userid=$P{userid}