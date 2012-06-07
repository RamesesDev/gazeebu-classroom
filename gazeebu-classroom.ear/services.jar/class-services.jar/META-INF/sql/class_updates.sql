[get-updates]
 select 
	m.objid, m.dtposted, m.userid, m.msgtype, m.channelid, m.threadid,
	u.lastname, u.firstname, u.middlename,
	c.name as classname, c.objid as classid
 from class_membership cm
 inner join class c on c.objid = cm.classid
 inner join message m on m.channelid = c.objid and m.msgtype <> 'private'
 inner join userprofile u on u.objid = m.userid
 where cm.userid = $P{userid} and m.dtposted < $P{lastdtposted}
 order by m.dtposted desc
 limit 8