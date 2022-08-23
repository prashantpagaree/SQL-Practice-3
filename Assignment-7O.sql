USE ASSIGN7;
create table venue(
VenueID int,
VenueName varchar(3),
Rating int);
select * from venue ORDER BY Rating;
Insert into venue values(1,'AB',2),(2,'BC',3),(3,'CD',1),(4,'DE',3),(5,'EF',4),
                        (6,'FG',5),(7,'GH',3),(8,'HI',4),(9,'IJ',2),(10,'JK',1);
--Write a query to categorise the ratings into buckets and then output the
--count of venues into each bucket
--Buckets for Ratings are as follows:
--1-2 – Good
--3-4 – Average
--5 – Worst
select   case 
	     when Rating >=1 and Rating <=2 then 'Good'
	     when Rating >=3 and Rating <=4 then 'Average'
	     when Rating =5 then 'Worst' end as Rating_New, Count(*) as Total_Venues from venue
		 group by case 
	     when Rating >=1 and Rating <=2 then 'Good'
	     when Rating >=3 and Rating <=4 then 'Average'
	     when Rating =5 then 'Worst' end ;

--3. From the above resultant table, print the number of venues categorised
--in each bucket by applying case when in the group by clause and also
--find average rating in each bucket

select * from venue ORDER BY Rating;
select   case 
	     when Rating >=1 and Rating <=2 then 'Good'
	     when Rating >=3 and Rating <=4 then 'Average'
	     when Rating =5 then 'Worst' end as Rating_New, Count(*) as Total_No_Venues,
		 Avg(rating) as Avg_Ratings from venue
		 group by case 
	     when Rating >=1 and Rating <=2 then 'Good'
	     when Rating >=3 and Rating <=4 then 'Average'
	     when Rating =5 then 'Worst' end ;

--4. WAQ to print the output of the above question with any other method
--you can think of.

--5a. Sort the table by placing the records of Countries Canada &
--Mexico at the top and then sort rest of the records by Customer’ name

select * from Customers
order by case 
when Country in ('Canada','Mexico')  then 1
else 2 end asc, CustomerName;

--5b. Bucketize the countries into three categories - Tier1, Tier2 &
--Tier3(however you want) and find the count of customers in each of the buckets

select 
case when Country like '[A-H]%' then 'Tier1' 
when Country like '[I-Q]%' then 'Tier2'
when Country like '[R-Z]%' then 'Tier3' 
end as Bucket,Count(CustomerID) as Total_customers from Customers
group by case when Country like '[A-H]%' then 'Tier1' 
when Country like '[I-Q]%' then 'Tier2'
when Country like '[R-Z]%' then 'Tier3' 
end;

--5c. Bucketize the postal codes into categories utilising their length as
--the parameter for bucketing and find the count of customers in
--each bucket and order them in ascending order of their customer count

select 
case when len(PostalCode)<=4 then 'Group1' 
when len(PostalCode)<=5 then 'Group2'
when len(PostalCode)>=7 then 'Group3'
end as Postal_Code_Buckets,Count(CustomerID) as Total_customers from Customers
group by case when len(PostalCode)<=4 then 'Group1' 
when len(PostalCode)<=5 then 'Group2'
when len(PostalCode)>=7 then 'Group3' 
end having case when len(PostalCode)<=4 then 'Group1' 
when len(PostalCode)<=5 then 'Group2'
when len(PostalCode)>=7 then 'Group3'
end is not null;