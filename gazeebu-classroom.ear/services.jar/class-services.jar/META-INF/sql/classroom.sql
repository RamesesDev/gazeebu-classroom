[members]
select u.objid,u.lastname,u.firstname,u.profile,cs.usertype as membertype 
from userprofile u 
inner join class_membership cs on cs.userid = u.objid 
where cs.classid = $P{classid}
order by u.usertype, u.lastname, u.firstname


