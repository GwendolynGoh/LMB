create schema sample;
use sample;

CREATE TABLE Aircraft (
       aid                  int NOT NULL,
       aname                varchar(20) ,
       cruisingrange         int,
       CONSTRAINT AircraftPK PRIMARY KEY (aid)
);
CREATE TABLE Employee (
       eid                  int NOT NULL,
       ename                varchar(20) ,
       salary               int,
       CONSTRAINT EmployeePK PRIMARY KEY (eid)
);
CREATE TABLE Certified (
       eid                  int NOT NULL,
       aid                  int NOT NULL,
       CertDate	   Date NOT NULL,
       CONSTRAINT CertifiedPK PRIMARY KEY (eid, aid),
       CONSTRAINT EmpFK FOREIGN KEY (eid) REFERENCES Employee  (eid),
       CONSTRAINT AircraftFK FOREIGN KEY (aid) REFERENCES Aircraft  (aid)
);
CREATE TABLE Flight (
       flno                  int NOT NULL,
       fly_from           varchar(20),
       fly_to               varchar(20),
       distance          int,
       price                int,
       CONSTRAINT FlightPK PRIMARY KEY (flno)
);

INSERT INTO EMPLOYEE VALUES(1,'Jacob',85000);
INSERT INTO EMPLOYEE VALUES(2,'Michael',55000);
INSERT INTO EMPLOYEE VALUES(3,'Emily',80000);
INSERT INTO EMPLOYEE VALUES(4,'Ashley',110000);
INSERT INTO EMPLOYEE VALUES(5,'Daniel',80000);
INSERT INTO EMPLOYEE VALUES(6,'Olivia',70000);

INSERT INTO AIRCRAFT VALUES(1,'a1',800);
INSERT INTO AIRCRAFT VALUES(2,'a2b',700);
INSERT INTO AIRCRAFT VALUES(3,'a3',1000);
INSERT INTO AIRCRAFT VALUES(4,'a4b',1100);
INSERT INTO AIRCRAFT VALUES(5,'a5',1200);

INSERT INTO FLIGHT VALUES(1,'LA','SF',600,65000);
INSERT INTO FLIGHT VALUES(2,'LA','SF',700,70000);
INSERT INTO FLIGHT VALUES(3,'LA','SF',800,90000);
INSERT INTO FLIGHT VALUES(4,'LA','NY',1000,85000);
INSERT INTO FLIGHT VALUES(5,'NY','LA',1100,95000);

INSERT INTO CERTIFIED VALUES(1,1,'2005-01-01');
INSERT INTO CERTIFIED VALUES(1,2,'2001-01-01');
INSERT INTO CERTIFIED VALUES(1,3,'2000-01-01');
INSERT INTO CERTIFIED VALUES(1,5,'2000-01-01');
INSERT INTO CERTIFIED VALUES(2,3,'2002-01-01');
INSERT INTO CERTIFIED VALUES(2,2,'2003-01-01');
INSERT INTO CERTIFIED VALUES(3,3,'2003-01-01');
INSERT INTO CERTIFIED VALUES(3,5,'2004-01-01');


#Part 1
select eid
from certified
where aid = 1;


#Part 2
select fly_to
from flight
order by fly_to desc;


#Part 3
select eid
from employee
where salary >= 70000
and salary <= 100000;


#Part 4
select max(cruisingrange)
from aircraft;


#Part 5
select e.ename, e.salary, a.aname
from employee e left outer join certified c
on e.eid = c.eid
left outer join aircraft a
on c.aid = a.aid;


#Part 6
alter table employee
add column speAircraft int;

update employee
set speAircraft = 1
where eid = 1;

update employee
set speAircraft = 3
where eid = 2;

update employee
set speAircraft = 4
where eid = 3;

update employee
set speAircraft = 3
where eid = 4;


#Part 7
select fly_from, fly_to, min(price)
from flight
group by fly_from, fly_to;


#Part 8
select distinct eid
from certified c inner join aircraft a
on c.aid = a.aid
group by eid
having max(a.cruisingrange) > 1000;

select avg(salary)
from employee
where eid in
	(select distinct eid
	from certified c inner join aircraft a
	on c.aid = a.aid
	group by eid
	having max(a.cruisingrange) > 1000);
    
select distinct eid
from certified;
    
select ename, salary
from employee
where eid not in
	(select distinct eid
	from certified)
and salary > 
	(select avg(salary)
	from employee
	where eid in
		(select distinct eid
		from certified c inner join aircraft a
		on c.aid = a.aid
		group by eid
		having max(a.cruisingrange) > 1000));
        

#Part 9
select eid
from certified
group by eid
having count(aid) >= 2;

select e.eid, e.ename, min(a.cruisingrange)
from employee e inner join certified c
on e.eid = c.eid
inner join aircraft a
on a.aid = c.aid
where c.eid in
	(select eid
	from certified
	group by eid
	having count(c.aid) >= 2)
group by e.eid, e.ename;


#Part 10
select e.ename, a.aname, c.certdate
from employee e inner join certified c
on e.eid = c.eid
inner join aircraft a
on c.aid = a.aid
where a.aname like '%b%';


#Part 11
select min(price)
from flight
where fly_from = 'LA'
and fly_to = 'SF'
group by fly_from, fly_to;

select ename, salary
from employee
where salary < 
	(select min(price)
	from flight
	where fly_from = 'LA'
	and fly_to = 'SF'
	group by fly_from, fly_to);


#Part 12
select distinct c.aid
from certified c inner join employee e
where e.ename = 'jacob';

select c.aid
from certified c inner join
	(select distinct c.aid
	from certified c inner join employee e
	where e.ename = 'jacob') as temp
on temp.aid = c.aid
group by c.aid
having count(distinct c.eid) = 1;


#Part 13
select a.aname
from employee e inner join certified c
on e.eid = c.eid
inner join aircraft a
on a.aid = c.aid
group by a.aname
having max(e.salary) <= 85000
and min(e.salary) >= 60000;


#Part 14
select distance
from flight
where flno = 3;

select eid
from certified c inner join aircraft a
on c.aid = a.aid
group by eid
having min(cruisingrange) > 
	(select distance
	from flight
	where flno = 3);
    
select ename, salary
from employee
where salary > 70000
and eid in
	(select eid
	from certified c inner join aircraft a
	on c.aid = a.aid
	group by eid
	having min(cruisingrange) > 
		(select distance
		from flight
		where flno = 3));
        
        
#Part 15

select eid
from certified c inner join aircraft a
on c.aid = a.aid
where a.aname like '%b';

select eid
from certified c inner join aircraft a
on c.aid = a.aid
where cruisingrange > 1000
and c.eid not in
	(select eid
	from certified c inner join aircraft a
	on c.aid = a.aid
	where a.aname like '%b');
    
select ename
from employee
where eid in
	(select eid
	from certified c inner join aircraft a
	on c.aid = a.aid
	where cruisingrange > 1000
	and c.eid not in
		(select eid
		from certified c inner join aircraft a
		on c.aid = a.aid
		where a.aname like '%b'));
        

#Part 16
select year(certdate), count(eid)
from certified
group by year(certdate);

select max(NoOfCert)
from
	(select year(certdate), count(eid) as NoOfCert
	from certified
	group by year(certdate)) as temp;

select year(certdate)
from certified
group by year(certdate)
having count(eid) =
	(select max(NoOfCert)
	from
		(select year(certdate), count(eid) as NoOfCert
		from certified
		group by year(certdate)) as temp);
        
        
#Part 17
select eid, max(cruisingrange)
from certified c inner join aircraft a
on c.aid = a.aid
group by eid;

select f.flno, temp.eid
from flight f, 
	(select eid, max(cruisingrange) as max_range
	from certified c inner join aircraft a
	on c.aid = a.aid
	group by eid) as temp
where f.distance < temp.max_range;

select temp2.flno, min(e.salary)
from employee e inner join
	(select f.flno, temp.eid
	from flight f, 
		(select eid, max(cruisingrange) as max_range
		from certified c inner join aircraft a
		on c.aid = a.aid
		group by eid) as temp
	where f.distance < temp.max_range) as temp2
    on temp2.eid = e.eid
    group by temp2.flno
    having min(e.salary);

select distinct eid
from certified;

select temp3.flno, e.ename
from employee e inner join
	(select temp2.flno, min(e.salary) as min_salary
	from employee e inner join
		(select f.flno, temp.eid
		from flight f, 
			(select eid, max(cruisingrange) as max_range
			from certified c inner join aircraft a
			on c.aid = a.aid
			group by eid) as temp
		where f.distance < temp.max_range) as temp2
		on temp2.eid = e.eid
		group by temp2.flno
		having min(e.salary)) as temp3
on temp3.min_salary = e.salary
and eid in
	(select distinct eid
	from certified);