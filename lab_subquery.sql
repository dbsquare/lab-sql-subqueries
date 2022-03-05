#LAB SUBQUERIES
-- How many copies of the film Hunchback Impossible exist in the inventory system?
select film_id, title 
from film 
where title = "Hunchback Impossible"; # Subquery

select count(inventory_id) 
from inventory
where film_id = (select film_id from film where title = "Hunchback Impossible");

-- List all films whose length is longer than the average of all the films.
select avg(length) from film;

select title
from film 
where length > (select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

select film_id from film where title = "Alone Trip";

select actor_id 
from film_actor 
where film_id = (select film_id from film where title = "Alone Trip");

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select category_id 
from category 
where name = "Family"; # SUB QUERY 1

select film_id from film_category where category_id = (select category_id 
from category 
where name = "Family"); # SUB QUERY 2

# THE ANSWER
select title 
from film 
where film_id in (select film_id from film_category where category_id = (select category_id 
from category 
where name = "Family")) ;


-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT concat(c.first_name, " ", c.last_name) as customers, c.email
from customer c
join address a
on a.address_id = c.address_id

join city ci
on ci.city_id = a.city_id

join country co
on co.country_id = ci.country_id

where country = "Canada";


-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select actor_id
from film_actor
group by actor_id
order by count(actor_id) desc
limit 1; #SUB QUERY to get the most prolific actor


select film_id
from film_actor
where actor_id = (select actor_id
from film_actor 
group by actor_id
order by count(actor_id) desc
limit 1) ;

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select sum(amount), customer_id
from payment
group by customer_id
order by sum(amount)
limit 1; #SUB QUERY to get teh most profitable customer

select f.title, r.customer_id 
from rental r
join customer c
on c.customer_id = r.customer_id

join inventory i 
on r.inventory_id = i.inventory_id

join film f
on i.film_id = f.film_id

where r.customer_id = (select customer_id
from payment
group by customer_id
order by sum(amount)
limit 1);

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

