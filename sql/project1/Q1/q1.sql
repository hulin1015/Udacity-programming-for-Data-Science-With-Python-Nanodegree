/* Query #1 */

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
order by 2,1
WHERE t1.category_name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family','Music')

