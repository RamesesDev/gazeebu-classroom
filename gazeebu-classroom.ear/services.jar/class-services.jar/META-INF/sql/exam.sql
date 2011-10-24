[exams]
select * from exam where classid=$P{classid} order by examdate

[results-byclass]
select r.* from exam_result r 
inner join exam e on r.examid=e.objid  
where e.classid=$P{classid} 


[results-byexam]
select * from exam_result r where r.examid = $P{examid}
