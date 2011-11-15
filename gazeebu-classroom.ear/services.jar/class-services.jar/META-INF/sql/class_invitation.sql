[list]
select ci.classid, ci.usertype, 
ci.userid as userid, c.name as classname, c.description as classdesc, ci.dtinvite,ci.msg, concat(u.lastname,', ',u.firstname) as sendername 
from class_invitation ci 
inner join class c on ci.classid = c.objid 
inner join userprofile u on ci.senderid = u.objid 
where ci.recipientid = $P{recipientid} order by ci.dtinvite desc 

[find-classes]
select * from class_membership cm 
inner join class c on c.objid=cm.classid 
where cm.userid=$P{userid}