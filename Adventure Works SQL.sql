use pro1;

select *,
year(orderdate) as "Year",
month(orderdate) as "Month",
monthname(orderdate) as "Month Full Name",
quarter(orderdate) as "Quarter",
concat(year(orderdate),"-",monthname(orderdate)) as "Year Month",
weekday(orderdate) as "Weekday Number",
dayname(orderdate) as "Weekday Name",
case when month(orderdate) = 1 then 10
when month(orderdate) = 2 then 11
when month(orderdate) = 3 then 12
when month(orderdate) = 4 then 1
when month(orderdate) = 5 then 2
when month(orderdate) = 6 then 3
when month(orderdate) = 7 then 4
when month(orderdate) = 8 then 5
when month(orderdate) = 9 then 6
when month(orderdate) = 10 then 7
when month(orderdate) = 11 then 8
else 9
end as "Financial Month",
case when month(orderdate) between 1 and 3 then "Q4" 
when month(orderdate) between 3 and 6 then "Q1" 
when month(orderdate) between 6 and 9 then "Q2" 
else "Q3"
end as "Financial Quarter"
from sales;


-- Year Wise Sales

select 
year(orderdate)
as "Year",
concat("₹ ",format((sum(sales)/1000),0),"K")
as "Sales"
from sales
group by year(orderdate)
order by year(orderdate) desc;


-- Month Wise Sales

select 
monthname(orderdate)
as "Month",
concat("₹ ",format((sum(sales)/1000000),2),"M")
as "Sales"
from sales
group by monthname(orderdate)
order by sum(sales) desc;


-- Quarter Wise Sales

select 
Quarter,
concat("₹ ",format((sum(sales)/1000000),2),"M")
as "Sales"
from sales
group by quarter
order by sum(sales) desc;


-- Yearly & Quarterly Sales & Production Cost

select
year(orderdate)
as "Year",
quarter
as "Qaurter",
concat("₹ ",format((sum(sales)/1000000),2),"M")
as "Sales",
concat("₹ ",format((sum(productcost)/1000000),2),"M")
as "Production Cost"
from Sales
group by year(orderdate), quarter
order by year(orderdate), quarter desc;


-- Region Wise Sales

select
st.salesterritoryregion
as "Region",
concat("₹ ",format((sum(s.sales)/1000000),2),"M")
as "Sales"
from sales as s
inner join 
territory as st
on s.salesterritorykey = st.salesterritorykey
group by salesterritoryregion
order by sum(sales) desc;


-- Customer Records Age Wise

select
c.AgeRange
as "Age Range",
concat(format((count(s.productkey)/1000),2),"K")
as "No. of Orders"
from Sales as s
inner join
customer as c
on s.customerkey = c.customerkey
group by agerange
order by agerange;


-- Top 5 Most Profitable Products

select 
p.modelname
as "Product",
concat("₹ ",format((sum(s.profit)/1000000),3),"M")
as "Profit"
from sales as s
inner join
product as p
on s.productkey = p.productkey
group by p.modelname
order by sum(profit) desc
limit 5;


-- Bottom 5 Most Profitable Products

select 
p.modelname
as "Product",
concat("₹ ",format((sum(s.profit)/1000),2),"K")
as "Profit"
from sales as s
inner join
product as p
on s.productkey = p.productkey
group by p.modelname
order by sum(profit)
limit 5;


-- Top 10 Most Sold Products

select
EnglishProductName
as "Product",
concat(format((count(productkey)/1000),2),"K")
as "No. of Orders"
from sales
group by EnglishProductName
order by count(productkey) desc
limit 10;


-- No. of Orders Country Wise

select
st.SalesTerritoryCountry
as "Country",
concat(format((count(s.productkey)/1000),2),"K")
as "No. of Orders"
from sales as s
inner join
territory as st
on s.salesterritorykey = st.salesterritorykey
group by st.SalesTerritoryCountry
order by count(s.productkey) desc;


-- No. of Orders on Weekdays

select
weekdayname
as "Day",
concat(format((count(productkey)/1000),2),"K")
as "No. of Orders"
from sales
group by weekdayname
order by count(productkey) desc;
