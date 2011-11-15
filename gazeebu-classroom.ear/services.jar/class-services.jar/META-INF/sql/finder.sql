[personlist]
select  u.objid, concat(u.lastname, ', ', u.firstname ) as name, u.profile , u.roles 
from userprofile u  
where  concat(u.lastname, ', ', u.firstname ) like $P{name} 
and INSTR(u.roles, $P{usertype} ) > 0 
and not exists (select * from class_membership where classid=$P{classid} and userid=u.objid)