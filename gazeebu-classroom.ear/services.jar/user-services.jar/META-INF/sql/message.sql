[last-dtfiled]
select dtfiled from message where objid = ?

[public-messages]
select nf.*, u.lastname, u.firstname, u.profile 
from message nf 
inner join userprofile u on nf.senderid = u.objid 
where nf.channelid = $P{channelid} 
and nf.scope = 'public' and nf.parentid is null 
and nf.msgtype=$P{msgtype} and nf.dtfiled < $P{lastdtfiled} 
order by nf.dtfiled desc  
limit $P{limit}

[incoming-private-messages]
select nf.*,u.lastname, u.firstname, u.profile 
from message nf  
inner join userprofile u on nf.senderid = u.objid 
where exists (select * from message_recipient where msgid=nf.objid and userid=$P{userid}) 
and nf.channelid = $P{channelid}  
and nf.dtfiled < $P{lastdtfiled} 
and nf.msgtype = 'private' 
order by nf.dtfiled desc  
limit $P{limit}

[conversation]
select nf.*,u.lastname, u.firstname, u.profile from message nf 
inner join userprofile u on nf.senderid=u.objid 
where nf.channelid = $P{channelid} 
and nf.msgtype='private' 
and (exists (select * from message_recipient where msgid=nf.objid and userid=$P{userid}) 
or nf.senderid = $P{userid}) 
and  
(exists (select * from message_recipient where msgid=nf.objid and userid=$P{observerid}) 
or nf.senderid = $P{observerid})
and nf.dtfiled < $P{lastdtfiled} 
order by nf.dtfiled desc 
limit $P{limit}

[responses]
select msg.*, u.lastname, u.firstname, u.profile  from message msg 
inner join userprofile u on u.objid = msg.senderid 
where msg.parentid=$P{parentid} 
order by msg.dtfiled desc

[recipients]
select userid from message_recipient where msgid = ?