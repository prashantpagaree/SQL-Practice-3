CREATE DATABASE ASSIGN7;
USE ASSIGN7;

--import students.csv into database
SELECT * FROM STUDENTS;

--1a. Students who passed SQL or Excel but failed Python

	select *,Student_Name from Students where SQL_Pass_Fail = 'Pass' or Excel_Pass_Fail = 'Pass'
	intersect 
	select *, Student_Name from Students where Python_pass_Fail = 'Fail';

--1b. Students who passed Python or Excel but failed SQL

select *,Student_Name from Students where Python_Pass_Fail = 'Pass' or Excel_Pass_Fail = 'Pass'
intersect 
select *, Student_Name from Students where SQL_pass_Fail = 'Fail';

--1c. Students who passed SQL or Python but failed Excel

select *,Student_Name from Students where Python_Pass_Fail = 'Pass' or SQL_Pass_Fail = 'Pass'
intersect 
select *, Student_Name from Students where Excel_pass_Fail = 'Fail';

--1d. Students who failed SQL or Excel but passed Python

select *,Student_Name from Students where Excel_Pass_Fail = 'Fail' or SQL_Pass_Fail = 'Fail'
intersect 
select *, Student_Name from Students where Python_pass_Fail = 'Pass';

--1e. Students who failed Python or Excel but passed SQL

select *,Student_Name from Students where Python_Pass_Fail = 'Fail' or Excel_Pass_Fail = 'Fail'
intersect 
select *, Student_Name from Students where SQL_pass_Fail = 'Pass';

--1f. Students who failed SQL or Python but passed Excel

select *,Student_Name from Students where Python_Pass_Fail = 'Fail' or SQL_Pass_Fail = 'Fail'
intersect 
select *, Student_Name from Students where Excel_pass_Fail = 'Pass';


---22. Write a query to add a grade column in a given table. Allot grade to each
--student according to their score given in the table.
--Grades : A+, A, A-, B+, B, B-, C+, C-, C, D+, D, F( Score >=93 A+, Score < 60 F)



Create table marks(
ID INT,
NAME VARCHAR(10),
SCORE INT);
SELECT * FROM MARKS;
Insert into marks values(1,'Simisola',60),(2,'Ivan',80),(3,'Metodija',52),(4,'Callum',98),
                  (5,'Leia',84),(6,'Aparecida',82),(7,'Ursula',69),(8,'Ramazan',78),
				  (9,'Corona',87),(10,'Alise',57),(11,'Galadriel',89),(12,'Merel',99),
				  (13,'Cherice',55),(14,'Nithya',81),(15,'Elsad',71),(16,'Liisi',90),
				  (17,'Johanna',90),(18,'Anfisa',90),(19,'Ryosuke',97),(20,'Sakchai',61),
				  (21,'Elbert',63),(22,'Katelyn',51);

Select *,case when score >=93 then 'A+'when score >=90 then 'A' 
              when score >= 87 then 'A-'when score >=85 then 'B+'
              when score >=83 then 'B'when score >=80 then 'B-'
			  when score >=77 then 'C+'when score >=75 then 'C'
			  when score >=73 then 'D+'when score >=70 then 'D'
			  when score >= 60 then 'D-'when score < 60 then 'F'
			  end as Grade from MARKS;

--2.a Create a table from Marks table, containing the number of students who
--passed and failed according to their score.

Create table pass_fail(
result varchar(10),
NUMBER_OF_STUDENT INT);

INSERT INTO pass_fail 
       select case 
       when Score >= 60 then 'Pass'
       when Score < 60 then 'Fail' 
	   else NULL end as RESULT, COUNT(*) as NUMBER_OF_STUDENT from Marks
	   group by
	   case 
       when Score >= 60 then 'Pass'
       when Score < 60 then 'Fail' 
	   else NULL end;

select * from pass_fail;

--2.b create a table from marks, which have the following columns
Create table GRADES(
GRADE varchar(10),
NUMBER_OF_STUDENTS INT);

INSERT INTO GRADES
Select case   when score >=93 then 'A+'when score >=90 then 'A' 
              when score >= 87 then 'A-'when score >=85 then 'B+'
              when score >=83 then 'B'when score >=80 then 'B-'
			  when score >=77 then 'C+'when score >=75 then 'C'
			  when score >=73 then 'D+'when score >=70 then 'D'
			  when score >= 60 then 'D-'when score < 60 then 'F'
			  end as GRADE, COUNT(*) AS NUMBER_OF_STUDENTS from Marks
Group by case when score >=93 then 'A+'when score >=90 then 'A' 
              when score >= 87 then 'A-'when score >=85 then 'B+'
              when score >=83 then 'B'when score >=80 then 'B-'
			  when score >=77 then 'C+'when score >=75 then 'C'
			  when score >=73 then 'D+'when score >=70 then 'D'
			  when score >= 60 then 'D-'when score < 60 then 'F'
			  end;

SELECT * FROM GRADES;

--3a. Students whose names start with A and who joined in march

select *,case 
             when Student_Name like 'A%' and Month(Joining_Date) = 3 then Student_Name 
			 end as New from Students;

--3b. Students having C in their name and at least 7 characters in their name.

select *, case 
          when Student_Name like '%C%' and len(Student_Name)>=7 then Student_Name
		  end As New_Students from Students;

--3c. In which month the maximum number of students registered

select top 1 MONTH(Joining_Date) as Month,case
       when Month(Joining_Date)=1 then count(*)
	   when Month(Joining_Date)=2 then count(*)
	   when Month(Joining_Date)=3 then count(*)
	   when Month(Joining_Date)=4 then count(*)
	   when Month(Joining_Date)=5 then count(*)
	   when Month(Joining_Date)=6 then count(*)
	   when Month(Joining_Date)=7 then count(*)
	   when Month(Joining_Date)=8 then count(*)
	   when Month(Joining_Date)=9 then count(*)
	   when Month(Joining_Date)=10 then count(*)
	   when Month(Joining_Date)=11 then count(*)
	   when Month(Joining_Date)=12 then count(*)
	   end As Total_Registration from Students group by Month(Joining_Date) order by Count(*) desc;

--3d. Student with minimum duration(days, and months) in EXCEL, SQL and python.

select top 1 Student_Name, case
       when datediff(day,Joining_Date,Leaving_Date) = 0  then Student_Name else 1
	   end AS Min_Duration from Students order by datediff(day,Joining_Date,Leaving_Date) asc ;

--3e. Section wise average duration (days and months) of students in course.

--Day
select section, case
                when section = 'A' then avg(Datediff(day,Joining_Date,Leaving_Date))
				when section = 'B' then avg(Datediff(day,Joining_Date,Leaving_Date))
				when section = 'C' then avg(Datediff(day,Joining_Date,Leaving_Date))
				when section = 'D' then avg(Datediff(day,Joining_Date,Leaving_Date))
				END AS AVG_DURATION_IN_DAYS from Students group by Section;


--Month
select section, case
                when section = 'A' then avg(Datediff(Month,Joining_Date,Leaving_Date))
				when section = 'B' then avg(Datediff(Month,Joining_Date,Leaving_Date))
				when section = 'C' then avg(Datediff(Month,Joining_Date,Leaving_Date))
				when section = 'D' then avg(Datediff(Month,Joining_Date,Leaving_Date))
				END AS AVG_DURATION_IN_MONTH from Students group by Section;
