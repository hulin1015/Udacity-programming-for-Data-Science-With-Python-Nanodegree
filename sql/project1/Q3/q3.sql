/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 2 */

/*
Question 1:
We want to find out how the two stores compare in their count of rental orders during every month for all the years 
we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental
orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, 
store ID and count of rental orders fulfilled during that month.
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
