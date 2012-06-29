[add-session]
insert into sys_session 
(sessionid, username, userid, dtaccessed, dtexpiry) 
values ($P{sessionid}, $P{username}, $P{userid}, $P{dtaccessed}, $P{dtexpiry})

[get-session]
select * from sys_session where sessionid = $P{sessionid}

[remove-session]
delete from sys_session where sessionid = $P{sessionid}

[remove-host-sessions]
delete from sys_session where host=?

[list-username-sessions]
select sessionid from sys_session where username in (${usernames})

[list-session-usernames]
select username from sys_session where sessionid in (${sessionids})

[list-session-byuser]
select sessionid from sys_session where username = $P{username}

[update-date]
update sys_session set dtaccessed=$P{dtaccessed}, dtexpiry=$P{dtexpiry} where sessionid=$P{sessionid} 

[get-expired]
select sessionid from sys_session where dtexpiry <= $P{currentdate} 