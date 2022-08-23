use assign8;
select * from Products;
select * from Customers;
select * from ORDERS;
select * from OrderDetails;
select * from Suppliers;

--1. Find the favorite brand of all the CustomerID�s

select Top 1 Brand, Count(CustomerID) as total_Customers  from Orders LEFT JOIN OrderDetails on Orders.OrderID = OrderDetails.OrderID
LEFT JOIN Products on OrderDetails.ProductID = Products.ProductID group by Brand order by total_Customers desc;

--2. Find the orderID�s where only products with saleprice greater than 400 were ordered

select Orderdetails.OrderID, Sale_Price from Orders LEFT JOIN OrderDetails on Orders.OrderID = OrderDetails.OrderID
LEFT JOIN Products on OrderDetails.ProductID = Products.ProductID where Sale_Price>400 order by Sale_Price; 

--3. Find the supplierID who supplied stuff to 10+ customers who have the
--same email service provider as themselves. (Hint: Supplier First name
--occurs as a substring in the supplier email address)

select Suppliers.SupplierID,Email, COUNT(CustomerID) as Total_order, CustomerID
from Suppliers LEFT JOIN OrderDetails on Suppliers.SupplierID = OrderDetails.SupplierID
LEFT JOIN Orders on OrderDetails.OrderID = Orders.OrderID 
group by Email, Suppliers.SupplierID, CustomerID having Count(CustomerID)>10 order by Total_order Desc;


--44. There�s a shop-keeper who keeps track of all the scans and payments made
--using the QR code in his shop. He has two datasets (one for scans and one
--for successful payments)
--Scans: {User_id, timestamp}
--Payments: {User_id, timestamp}
--A. A user does multiple payments
--B. A user scans but doesn�t pay
--Rules
--A. A user can�t initiate a payment while another is processing
--scanning and completing a transaction successfully