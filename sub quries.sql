#subquerys
#Find films with rating above average rating

USE MOVIE_RENTEL;

SELECT TITLE,RATING
FROM FILM
WHERE RATING>(SELECT AVG(RATING)
		      from FILM);
              
#Find customers who have made at least one rental

SELECT name
FROM customer
WHERE customer_id IN (
    SELECT customer_id 
    FROM rental
);

#Find films that were never rented

SELECT NAME 
FROM CUSTOMER
WHERE CUSTOMER_ID NOT IN(SELECT CUSTOMER_ID
FROM RENTAL);

#Find customers who rented more than average number of films

SELECT c.name
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(r.rental_id) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM rental
        GROUP BY customer_id
    ) t
);

#Find customer(s) with maximum rentals (using subquery)

select c.name 
from rental r
join customer c on r.customer_id = c.customer_id
group by c.customer_id,c.name
having count(rental_id)=(select max(cnt)
from(
      select count(*) as cnt
      from rental
      group by customer_id)t
);


#Find second highest rated film using subquery

SELECT title, rating
FROM film
WHERE rating = (
    SELECT MAX(rating)
    FROM film
    WHERE rating < (
        SELECT MAX(rating)
        FROM film
    )
);


