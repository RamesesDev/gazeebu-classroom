[thread-list]
select d.*, (select count(*) from message where threadid=d.objid) as topic_count 
from discussion_thread d 
where d.classid=$P{classid} 
order by d.dtposted asc 
limit $P{limit} 

[topic-list]
select * from discussion_topic where parentid=$P{parentid} 
order by dtposted asc 
limit $P{limit} 

[topic-members]
select * from discussion_topic_subscriber where topicid=$P{parentid}

[resource-list]
select * from discussion_resource where parentid=$P{parentid}
