/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 2 */

/*
Question 2
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007, 
and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of 
payment, and total payment amount for each month by these top 10 paying customers?
*/


with t1 as(
           select c.first_name||''||c.last_name as full_name,
                  c.customer_id,
                  p.amount,
                  p.payment_date
            from customer c
            join payment p
            on c.customer_id = p.customer_id),
       t2 as(
            select customer_id
            from payment
            group by 1
            order by sum(amount)desc
            limit 10)
select t1.full_name,
       date_trunc('month',t1.payment_date) as pay_mon,
       count(*) as pay_countpermon,
       sum(t1.amount) as pay_amount
from t1
join t2
on t1.customer_id =t2.customer_id
where t1.payment_date between '20070101' and '20080101'
group by 1,2