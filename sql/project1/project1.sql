/* Question #1 */
/*
We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
*/

with t1 as (
           select f.title as film_title,
                  c.name as category_name
           from film f
           join film_category fc
           on f.film_id = fc.film_id
           join category c
           on c.category_id = fc.category_id),
     t2 as (           
           select f.title as film_title,
                  count(*) as rental_count
           from rental r
           join inventory i
           on r.inventory_id = i.inventory_id
           join film f
           on i.film_id = f.film_id
           group by 1
           order by 2)
select t1.film_title,
       t1.category_name,
       t2.rental_count       
from t1
join t2
on t1.film_title = t2.film_title
WHERE t1.category_name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family','Music')
order by 2,1;

/* Question #2 */
/*
Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 
4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category 
that these family-friendly movies fall into.
*/

select f.title,
       c.name,
       f.rental_duration,
       ntile(4)over(order by rental_duration) as standard_quartile
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE c.name IN ('Animation', 'Children','Classics','Comedy','Family','Music')        
order by 4;



/* Question #3 */
/*
We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental
orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.
*/

select date_part('month', r.rental_date) as rental_month, 
       date_part('year', r.rental_date) aS rental_year,
       s1.store_id,
       count(*) as count_rental
from store  s1
       join staff  s2
        on s1.store_id = s2.store_id	
       join rental r
        on s2.staff_id = r.staff_id
group by 1, 2, 3
order by 2, 1;



/* Question 4 */
/*
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007, and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of 
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
group by 1,2;

