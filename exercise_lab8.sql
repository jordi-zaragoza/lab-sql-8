USE sakila;
-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country FROM store AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
LEFT JOIN city AS c
ON a.city_id = c.city_id
LEFT JOIN country AS co
ON c.country_id = co.country_id; -- Done

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id,
    sum(p.amount)
FROM payment AS p
LEFT JOIN staff AS s
ON p.staff_id = s.staff_id
GROUP BY p.staff_id;

-- 3. Which film categories are longest?
SELECT 
    c.name,
    avg(f.length) AS length_avg
FROM film AS f 
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY fc.category_id
ORDER BY length_avg DESC; -- done

-- 4. Display the most frequently rented movies in descending order.
SELECT 
	f.title,
	count(r.rental_id) AS "Num_rents"
FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON i.film_id = f.film_id
GROUP BY i.film_id
ORDER BY Num_rents DESC; -- Done

-- 5. List the top five genres in gross revenue in descending order.
SELECT
	c.name,
    sum(p.amount) AS revenue
FROM payment AS p
JOIN rental AS r
ON p.rental_id = r.rental_id
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film_category AS fc
ON i.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5; -- Done
    

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
	f.title,
    i.store_id
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "ACADEMY DINOSAUR" AND i.store_id = 1; -- Done

-- 7. Get all pairs of actors that worked together.
SELECT 
    f.title,
    a.first_name AS name1,
    a.last_name AS last1
FROM film_actor AS fc
JOIN actor AS a
ON fc.actor_id = a.actor_id
JOIN film AS f
ON fc.film_id = f.film_id
ORDER BY fc.film_id; -- Done

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
select * from rental;
select * from inventory;
select * from rental;

SELECT 
    i.film_id,
	r.customer_id,
    count(r.rental_id) AS times_rent
FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
-- WHERE count(r.rental_id) > 3  -- WHy this is not working
GROUP BY r.customer_id, i.film_id
ORDER BY film_id ASC;


-- 9. For each film, list actor that has acted in more films.
select 
	actor_id,
    count(film_id) AS num_films
FROM film_actor
GROUP BY actor_id;
-- WHERE num_films > 1;