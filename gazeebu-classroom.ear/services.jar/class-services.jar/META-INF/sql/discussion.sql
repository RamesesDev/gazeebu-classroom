[thread-list]
select * from discussion_thread where classid=$P{classid} 
order by dtposted asc 
limit $P{limit} 

[topic-list]
select * from discussion_topic where parentid=$P{objid} 
order by dtposted asc 
limit $P{limit} 

