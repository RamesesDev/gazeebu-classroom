[members]
select u.objid,u.lastname,u.firstname,u.profile,cs.usertype as usertype 
from userprofile u 
inner join class_membership cs on cs.userid = u.objid 
where cs.classid = $P{classid}
order by cs.usertype, u.lastname, u.firstname
