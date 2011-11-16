[list]
select ci.classid, ci.usertype, 
ci.userid as userid, c.name as classname, c.schedules as schedules, ci.dtinvite,ci.msg, concat(u.lastname,', ',u.firstname) as sendername 
from class_invitation ci 
inner join class c on ci.classid = c.objid 
inner join userprofile u on ci.senderid = u.objid 
where ci.recipientid = $P{recipientid} order by ci.dtinvite desc 

[find-invitees]
select  u.objid, concat(u.lastname, ', ', u.firstname ) as name, u.profile , u.roles 
from userprofile u  
where  concat(u.lastname, ', ', u.firstname ) like $P{name} 
and INSTR(u.roles, $P{usertype} ) > 0 
and not exists (select * from class_membership where classid=$P{classid} and userid=u.objid)

[teacher-class]
select cm.classid, cm.userid as teacherid, concat(u.lastname, ', ', u.firstname ) as name, c.name as classname, c.schedules as schedules, u.profile  
from class_membership cm 
inner join userprofile u on cm.userid=u.objid 
inner join class c on cm.classid = c.objid 
where cm.usertype='teacher' 
and concat(u.lastname, ', ', u.firstname ) like $P{name} 
and not exists (select * from class_membership where classid=c.objid and userid=$P{userid}) 
