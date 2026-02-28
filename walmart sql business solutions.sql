use walmart
select * from walmart;

-- Business Problems

-- 1. What are the different payment methods, and how many transactions and
-- items were sold with each method ?
select payment_method , count(*) as total_transactions , sum(quantity) as total_items_sold
from walmart 
group by payment_method ;
-- 2. Which category received the highest average rating in each branch? 

select branch, category, avg_rating as highest_avg_rating
from (
select branch, category, avg(rating) as avg_rating,
rank() over(partition by branch order by avg(rating) desc) as rnk
from walmart
group by branch,category
order by branch ) as t1 
where rnk=1  ;

-- 3. What is the busiest day of the week for each branch based on transaction volume?

alter table walmart 
add new_date date ;

UPDATE walmart
SET new_date = str_to_date(date, '%d/%m/%y');

select * from walmart ; 
  -- now we can drop the date column and make the new_date column to date column by changing the name
  
select new_date, dayname(new_date)  as day
from walmart ;

select branch, day as busiest_day, no_of_transactions
from (
select branch, dayname(new_date)  as day, count(*) as no_of_transactions,
rank() over(partition by branch order by count(*) desc) as rnk 
from walmart
group by branch, dayname(new_date) 
order by branch ) as t1 
where rnk = 1 ;

-- 4.  How many items were sold through each payment method ? 

select payment_method , sum(quantity) as total_tems_sold
from walmart 
group by payment_method ;

-- 5. What are the average, minimum, and maximum ratings for each category in each city?

select city, category, min(rating) as min_rating, max(rating) as max_rating,  
avg(rating) as avg_rating
from walmart 
group by city, category ;

-- 6. What is the total profit for each category, ranked from highest to lowest? 

select category, sum(total) as total_revenue ,
sum(total*profit_margin) as total_profit
from walmart
group by category
order by total_profit desc ;

-- 7. What is the most frequently used payment method in each branch ?

select branch, payment_method, total_transaction
from (
select branch, payment_method, count(*) as total_transaction,
rank() over(partition by branch order by count(*) desc) as rnk
from walmart
group by branch, payment_method
order by Branch ) as t1
where rnk=1 ;

-- 8. How many transactions occur in each shift (Morning, Afternoon, Evening) across branches?

select * from walmart ;

alter table walmart
add new_time time ;

update walmart 
set new_time = str_to_date(time, '%H:%i:%s') ;


select branch, 
CASE
    WHEN hour(new_time)<12 THEN 'morning'
    WHEN hour(new_time) BETWEEN 12 AND 17 THEN 'afternoon'
    ELSE 'evening'
END shift, count(*) as no_of_trans
from walmart 
group by branch, shift
order by branch ;


-- 9. Identify the 5 branches with the highest revenue decrease ratio from last year to 
--    current year (e.g., 2022 to 2023) ?

with prev_rev as 
( select branch, sum(total) as total_rev
from walmart 
where year(new_date) = 2022
group by branch 
order by branch 
),
current_rev as 
( select branch, sum(total) as total_rev
from walmart
where year(new_date) = 2023
group by branch 
order by branch
)

select pr.branch, pr.total_rev as rev_2022, cr.total_rev as rev_2023,
round(((pr.total_rev - cr.total_rev  ) / pr.total_rev) *100 ,2) as revenue_decrease_ratio
from prev_rev pr
join current_rev cr
on pr.branch = cr.branch 
where pr.total_rev > cr.total_rev  
order by revenue_decrease_ratio desc 
limit 5;












