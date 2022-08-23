create database assign8;
use assign8;

create table A(
ID int ,
a char(5));

insert into A values(1,'A'),(2,'A'),(2,'A'),(3,'A'),(3,'A'),(4,'A'),(2,'A'),(NULL,'A');
SELECT * FROM B
create table B(
ID int,
b char(5));
insert into B values(1,'B'),(1,'B'),(2,'B'),(3,'B'),(5,'B'),(NULL,'B');

select * from  A inner join  B on A.ID=B.ID;
select * from  A left join  B on A.ID=B.ID;
select * from  A right join  B on A.ID=B.ID;
select * from  A full outer join  B on A.ID=B.ID;

select* from Projects;
select * from worker;

--1. Get Worker name, project name order by first name from "Worker" and "Projects" for those
--worker which have been assigned project already

select concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME) as Worker_Name, Projects.Project_Name from Worker 
inner join projects on Worker.WORKER_ID = Projects.Worker_ID order by Worker.FIRST_NAME;

--2. Get employee name, project name order by first name from "Worker" and "Projects"
--for all worker even if they have not been assigned a project

select concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME) as Worker_Name, Projects.Project_Name from Worker 
left join projects on Worker.WORKER_ID = Projects.Worker_ID order by Worker.FIRST_NAME;

--3. Write down the query to fetch Worker & Project who have been assigned more than one project.

select Worker.Worker_ID ,concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME) as Worker_Name, 
Count(concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME)) as Total_Projects from Worker 
full outer join projects on Worker.WORKER_ID = Projects.Worker_ID where Worker.WORKER_ID is not null
group by  concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME) ,Worker.Worker_ID
having Count(concat(Worker.FIRST_NAME,' ',Worker.LAST_NAME)) >1 ;

--4. Get complete record(employee name, project name) from both tables([Worker],[
--Project]), if no match is found in any table then show NULL.

select Worker.*, Projects.* from Worker 
full outer join Projects on Worker.WORKER_ID = Projects.Worker_ID;

--5. Get all project name even they have not matching any Worker ID, in left table, order
--by firstname from " Worker " and " Projects "

select Projects.Project_Name,  Worker.WORKER_ID from Worker 
left join projects on Worker.WORKER_ID = Projects.Worker_ID order by Worker.FIRST_NAME ;

