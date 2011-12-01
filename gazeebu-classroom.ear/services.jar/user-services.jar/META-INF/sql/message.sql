[last-dtfiled]
select dtfiled from message where objid = ?

[public-messages]
select nf.* 
from message nf 
where nf.channelid = $P{channelid} 
and nf.scope = 'public' and nf.parentid is null 
and nf.msgtype=$P{msgtype} and nf.dtfiled < $P{lastdtfiled} 
order by nf.dtfiled desc  
limit $P{limit}

[public-context-messages]
select nf.* 
from message nf 
where nf.parentid=$P{parentid} 
and nf.msgtype=$P{msgtype} and nf.dtfiled < $P{lastdtfiled} 
order by nf.dtfiled desc  
limit $P{limit}

[incoming-private-messages]
select nf.* 
from message nf  
where exists (select * from message_recipient where msgid=nf.objid and userid=$P{userid}) 
and nf.channelid = $P{channelid}  
and nf.dtfiled < $P{lastdtfiled} 
and nf.msgtype = 'private' 
order by nf.dtfiled desc  
limit $P{limit}

[conversation]
select nf.* from message nf 
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
select msg.*  from message msg 
where msg.parentid=$P{parentid}  
order by msg.dtfiled desc

[recipients]
select userid from message_recipient where msgid = ?

[remove-recipients]
delete from message_recipient where msgid=$P{objid}

[remove-unsubscribe]
delete from message_unsubscribe where msgid=$P{objid}

[remove-message]
delete from message where objid=$P{objid}

[remove-comments]
delete from message where parentid=$P{objid}

