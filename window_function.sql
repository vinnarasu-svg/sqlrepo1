use movie_rentel;

#Show each film with its rating and overall average rating.

select title,rating ,
avg(rating) over () as avg_rating
from film;

#Show each film’s rating along with the total number of films (using window function)

select title,rating,
count(title) over() as total_film
from film;

#Show each customer with their total rentals using window function (no GROUP BY)

select c.name,
count(r.rental_id) over(partition by c.customer_id ) as total_rental
from rental r
join customer c on r.customer_id = c.customer_id;  

#Assign row number to films based on rating (highest first)

select title,
row_number() over( order by title  desc) as rn
from film;

#Give each customer a row number based on rental date (latest first)

select c.name,
row_number()over (order by r.rental_date desc) as rn
from  rental r
join customer c on r.customer_id = c.customer_id;

#Show films with row numbers within each genre

select title,genre,
row_number() over(partition by genre order by rating desc) as rn
from film;

#Rank films using RANK() based on rating

select title,
rank() over (order by rating desc) as rnk
from film;

#Use DENSE_RANK() to rank films (no gaps)

select title,rating,
dense_rank () over(order by rating desc) as dns_rnk
from film;

#Find top 3 highest rated films using DENSE_RANK()

with ranked_film as (
select title,rating,
dense_rank () over(order by rating desc) as dns_rnk
from film
)
select * 
from ranked_film
where dns_rnk<=3;

#Show customers ranked by number of rentals

select c.name,
count(r.rental_id)as total_rental,
dense_rank() over (order by count(r.rental_id)  desc) as rnk
from rental r
join customer c on r.customer_id=c.customer_id
group by c.customer_id,c.name;

#Find highest rented customer in each city

WITH customer_rentals AS (
    SELECT 
        c.customer_id,
        c.name,
        c.city,
        COUNT(r.rental_id) AS total_rentals,
        DENSE_RANK() OVER (
            PARTITION BY c.city 
            ORDER BY COUNT(r.rental_id) DESC
        ) AS rnk
    FROM customer c
    JOIN rental r 
    ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.name, c.city
)
SELECT 
    name,
    city,
    total_rentals
FROM customer_rentals
WHERE rnk = 1;

#Find customers whose rentals are above city average

WITH customer_rentals AS (
    SELECT 
        c.customer_id,
        c.name,
        c.city,
        COUNT(r.rental_id) AS total_rentals,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.city) AS avg_city_rentals
    FROM customer c
    JOIN rental r 
    ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.name, c.city
)
SELECT 
    name,
    city,
    total_rentals,
    avg_city_rentals
FROM customer_rentals
WHERE total_rentals > avg_city_rentals;