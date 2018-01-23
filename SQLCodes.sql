#Name: Gwendolyn Goh (ID: S9531292F)

#Qn.1
select sid, sname
from student
where school = 'sis';

#Qn.2
select cid, sno
from section
where day <> 'monday';

#Qn.3
select cid, title
from course
where title like '%a%'
order by cid desc;

#Qn.4
select b.cid, b.sno, b.sid, b.bid
from student s inner join bidding b
on s.sid = b.sid
where s.school = 'sis';

#Qn.5
create table semester(
sid int primary key,
name varchar(20) not null);

insert into semester values
(1, '2015-16 Term1'),
(2, '2015-16 Term2'),
(3, '2015-16 Term3A');

#Qn.6
create table section_ta(
cid varchar(10) not null,
sno int not null,
sid int not null,
constraint section_ta_pk primary key(cid, sno, sid),
constraint section_ta_fk1 foreign key(cid, sno) references section(cid, sno),
constraint section_ta_fk2 foreign key(sid) references student(sid));

#Qn.7
select b.cid, c.title, b.sno, b.sid, s.sname, b.bid
from bidding b left outer join course c
on b.cid = c.cid
left outer join student s
on s.sid = b.sid;

#Qn.8
select fid, fname
from faculty
where fid not in
	(select distinct fid
	from section);
    
#Qn.9
select distinct b.cid, c.title, b.sno, temp.max_bid, temp.min_bid, temp.avg_bid
from course c inner join bidding b
on c.cid = b.cid
inner join
	(select distinct cid, sno, max(bid) as max_bid, min(bid) as min_bid, avg(bid) as avg_bid
	from bidding
	group by cid, sno) as temp
on temp.cid = b.cid
and temp.sno = b.sno;

#Qn.10
select s.sid, s.sname, count(distinct b.cid)
from student s left outer join bidding b
on s.sid = b.sid
group by s.sid, s.sname;

#Qn.11
select distinct fid, fname
from faculty
where fid in
	(select fid
	from section s inner join course c
	on s.cid = c.cid
	where c.title = 'machine learning')
or fid in
	(select fid
	from section sec inner join bidding b
	on sec.cid = b.cid
	and sec.sno = b.sno
	inner join student stu
	on b.sid = stu.sid
	where stu.sname = 'ama'
	and stu.school = 'sis');
    
#Qn.12
select b1.cid, b1.sno, b1.sid, b2.sid, b1.bid
from bidding b1, bidding b2
where b1.sid < b2.sid
and b1.cid = b2.cid
and b1.sno = b2.sno
and b1.bid = b2.bid;

#Qn.13
select cid, sno, num_bid
from 
	(select cid, sno, count(bid) as num_bid
	from bidding
	group by cid, sno) as temp
where num_bid = 
	(select max(num_bid)
	from 
		(select cid, sno, count(bid) as num_bid
		from bidding
		group by cid, sno) as temp);
        
#Qn.14
select cid, title
from course
where cid not in
	(select cid from
	(select s.cid, s.sno
	from section s left outer join bidding b
	on s.cid = b.cid
	and s.sno = b.sno
	group by cid, sno
	having count(b.bid) = 0) as temp);
    
#Qn.15
select distinct b.cid, b.sno
from bidding b, 
	(select b.cid, b.sno
	from section se inner join bidding b
	on se.cid = b.cid
	and se.sno = b.sno
	inner join faculty f
	on se.fid = f.fid
	inner join student st
	on st.sid = b.sid
	where f.school = st.school) as temp
where b.cid <> temp.cid
and b.sno <> temp.sno;