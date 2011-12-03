[list-all]
select r.* from resource r where r.userid=$P{userid} and category=$P{category}

[find]
select * from resource where category=$P{category} and title like $P{title}
