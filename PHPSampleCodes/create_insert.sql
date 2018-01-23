create schema findmybus;
use  findmybus;

#service
create table service(servicenumber char(8) , starttime char(4), 
endtime char(4), frequency char(5),
constraint service_pk primary key(servicenumber));

LOAD DATA INFILE 'c:/IS202/data/services.txt' INTO TABLE service 
FIELDS TERMINATED BY ','  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#bus stop
create table bus_stop(stopnumber char(8) primary key, locationdesc varchar(50), address varchar(50));

LOAD DATA INFILE 'c:/IS202/data/bus-stops.txt' INTO TABLE bus_stop 
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#route
create table route (servicenumber char(8), routenumber int, remark varchar(70), 
startbusstop char(8), endbusstop char(8), 
constraint route_pk primary key(servicenumber, routenumber),
constraint route_fk1 foreign key(servicenumber) references service(servicenumber),
constraint route_fk2 foreign key(startbusstop) references bus_stop(stopnumber), 
constraint route_fk3 foreign key(endbusstop) references bus_stop(stopnumber)
); 

LOAD DATA INFILE 'c:/IS202/data/route.txt' INTO TABLE route  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#bus route
create table bus_route (servicenumber char(8), routenumber int,  
stopnumber char(8), stoporder int, 
constraint bus_route_pk primary key(servicenumber, routenumber, stopnumber, stoporder),
constraint bus_route_fk1 foreign key(servicenumber,routenumber) 
references route(servicenumber, routenumber),
constraint bus_route_fk2 foreign key(stopnumber) references bus_stop(stopnumber)
); 


LOAD DATA INFILE 'c:/IS202/data/bus-route.txt' INTO TABLE bus_route  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#terminus
create table terminus(stopnumber char(8) primary key, lostfound char(8), 
starthour char(4), endhour char(4) ,
constraint terminus_fk foreign key(stopnumber) references bus_stop(stopnumber));


LOAD DATA INFILE 'c:/IS202/data/terminus.txt' INTO TABLE terminus  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#non-terminus

create table non_terminus(stopnumber char(8) primary key, 
epaper_in tinyint(1), 
installdate date, model varchar(20) ,
constraint non_terminus_fk foreign key(stopnumber) 
references bus_stop(stopnumber));

LOAD DATA INFILE 'c:/IS202/data/non-terminus.txt' INTO TABLE non_terminus  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#week_period
create table week_period(periodname varchar(15) primary key, 
remark varchar(50)
);

LOAD DATA INFILE 'c:/IS202/data/week-period.txt' INTO TABLE week_period  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#service_search
create table service_search(servicenumber char(8), 
periodname varchar(15), count int, 
constraint ssearch_pk primary key(servicenumber, periodname) ,
constraint ssearch_fk1 foreign key(servicenumber) references service(servicenumber), 
constraint ssearch_fk2 foreign key(periodname) references week_period(periodname)
); 

LOAD DATA INFILE 'c:/IS202/data/service-search.txt' INTO TABLE service_search  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#stop_search
create table stop_search(stopnumber char(8), 
periodname varchar(15), count int, 
constraint stopsearch_pk primary key(stopnumber, periodname) ,
constraint stopsearch_fk1 foreign key(stopnumber) references bus_stop(stopnumber), 
constraint stopsearch_fk2 foreign key(periodname) references week_period(periodname)
); 
 

LOAD DATA INFILE 'c:/IS202/data/stop-search.txt' INTO TABLE stop_search  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;
 

#bus
create table bus(platenumber char(8) primary key, model varchar(15), 
capacity int, dateacquired date);


LOAD DATA INFILE 'c:/IS202/data/bus.txt' INTO TABLE bus  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#driver

create table driver(
staffID int primary key, nric char(9), drivername varchar(30),  
licensenumber int, 
datecertified date);


LOAD DATA INFILE 'c:/IS202/data/driver.txt' INTO TABLE driver   
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#driver_offdays
                            
create table driver_offdays(staffid int , offday int,                                          
constraint driver_offdays_pk primary key(staffid, offday), 
constraint driver_offdays_fk1 foreign key(staffid) references driver(staffid)
);


LOAD DATA INFILE 'c:/IS202/data/driver-offdays.txt' INTO TABLE driver_offdays   
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\r\n'   IGNORE 1 LINES;


#trip

create table trip (tripid int primary key, 
servicenumber char(8), routenumber int, 
tripdate date, 
triptime time, 
busplate char(8), 
driver int, cancelled tinyint(1),
constraint trip_fk1 foreign key (servicenumber, routenumber) 
references route(servicenumber, routenumber),
constraint trip_fk2 foreign key (busplate) references bus(platenumber),
constraint trip_fk3 foreign key (driver) references driver(staffid) ) ;


LOAD DATA INFILE 'c:/IS202/data/trip.txt' INTO TABLE trip  
FIELDS TERMINATED BY '\t'  LINES TERMINATED BY '\n'   IGNORE 1 LINES;


#bus_location

create table bus_location (tripid int, 
loc_timestamp datetime, 
stopnumber char(8), 
locationX decimal(12,4) , 
locationY decimal(12,4), arrivalMins int,
constraint busloc_pk primary key (tripid, loc_timestamp), 
constraint busloc_fk1 foreign key (tripid) references trip(tripid),
constraint busloc_fk2 foreign key (stopnumber) references bus_stop(stopnumber)) ;



