create schema movie_rentel;

use  movie_rentel;

CREATE TABLE actor (
actor_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50)
);

INSERT INTO actor VALUES
(1,'Robert','Downey'),
(2,'Scarlett','Johansson'),
(3,'Chris','Evans'),
(4,'Tom','Holland'),
(5,'Emma','Watson'),
(6,'Leonardo','DiCaprio'),
(7,'Jennifer','Lawrence'),
(8,'Brad','Pitt'),
(9,'Angelina','Jolie'),
(10,'Will','Smith');


CREATE TABLE film (
film_id INT PRIMARY KEY,
title VARCHAR(100),
genre VARCHAR(50),
release_year INT,
rating DECIMAL(3,1)
);

INSERT INTO film VALUES
(101,'Galaxy War','Sci-Fi',2021,8.5),
(102,'Love Forever','Romance',2019,7.2),
(103,'Dark Mission','Action',2020,8.0),
(104,'Hidden Truth','Mystery',2018,7.8),
(105,'Dream World','Fantasy',2022,8.3),
(106,'Ocean Deep','Adventure',2017,7.5),
(107,'Night Hunter','Thriller',2023,8.1),
(108,'Broken Wings','Drama',2016,7.0);


CREATE TABLE film_actor (
actor_id INT,
film_id INT,
PRIMARY KEY(actor_id, film_id),
FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO film_actor VALUES
(1,101),
(2,101),
(3,103),
(4,103),
(5,105),
(6,104),
(7,107),
(8,106),
(9,108),
(10,102);

CREATE TABLE customer (
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO customer VALUES
(1,'Arun','Chennai'),
(2,'Priya','Bangalore'),
(3,'Rahul','Mumbai'),
(4,'Sneha','Delhi'),
(5,'Kiran','Hyderabad'),
(6,'Divya','Pune'),
(7,'Ravi','Chennai'),
(8,'Meena','Kolkata');

CREATE TABLE rental (
rental_id INT PRIMARY KEY,
customer_id INT,
film_id INT,
rental_date DATE,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO rental VALUES
(1,1,101,'2024-01-10'),
(2,2,103,'2024-01-11'),
(3,3,105,'2024-01-12'),
(4,4,104,'2024-01-13'),
(5,5,107,'2024-01-14'),
(6,6,106,'2024-01-15'),
(7,7,102,'2024-01-16'),
(8,8,108,'2024-01-17');

#SELECT
#Display all records from the film table.

use movie_rentel;
select* from film;

#Show only the title and release_year from the film table.

select title , release_year from film;

#Display all actors' first and last names.

select first_name , last_name from actor;

#Show all customers and the cities they belong to.

select name , city from customer;

#WHERE
#Find films released after 2020.

USE MOVIE_RENTEL;
SELECT TITLE , RELEASE_YEAR
FROM FILM 
WHERE RELEASE_YEAR >  '2020';

#Show films with rating greater than 8.0.

SELECT TITLE , RATING
FROM FILM
WHERE RATING > '8.0';

#Display customers who live in Chennai.

SELECT NAME,CITY
FROM CUSTOMER
WHERE CITY = 'CHENNAI';

#Find films with genre Action.

SELECT TITLE, GENRE
FROM FILM
WHERE GENRE = 'ACTION';

#ORDER BY
#Display films sorted by rating (highest first).

SELECT *
FROM FILM ORDER BY(RATING) DESC;

#Show actors ordered by first name.

SELECT * 
FROM ACTOR ORDER BY (FIRST_NAME) ;

#List films sorted by release year.

SELECT * 
FROM FILM ORDER BY(RELEASE_YEAR) ;

#Aggregate Functions
#Count total number of films.

SELECT COUNT(*) 
FROM FILM  ;

#Find the highest rating among films

SELECT MAX(RATING)
FROM FILM;

#Find the lowest rating among films.

SELECT MIN(RATING)
FROM FILM;

#Find the average film rating.

SELECT AVG(RATING)
FROM FILM;

#GROUP BY
#Count number of films in each genre.

SELECT GENRE ,COUNT(*)
FROM FILM
GROUP BY(GENRE);

#Find how many films were released in each year.

SELECT RELEASE_YEAR,COUNT(RELEASE_YEAR)
FROM FILM
GROUP BY(RELEASE_YEAR);

#Count number of customers in each city.

SELECT CITY,COUNT(CITY)
FROM CUSTOMER
GROUP BY (CITY);

#JOIN Queries
#Show customer name and film title they rented.

SELECT 
      CUSTOMER.NAME,
      FILM.TITLE AS FILM_TITLE
FROM  RENTAL JOIN CUSTOMER ON RENTAL.CUSTOMER_ID =CUSTOMER.CUSTOMER_ID
JOIN FILM ON  RENTAL.FILM_ID = FILM.FILM_ID;

#Show film title and rental date.

SELECT FILM.TITLE,RENTAL.RENTAL_DATE
FROM RENTAL JOIN FILM ON FILM.FILM_ID = RENTAL.FILM_ID; 

#Display actor names and film titles they acted in.

SELECT A.FIRST_NAME , F.TITLE
FROM FILM_ACTOR fa
JOIN ACTOR A ON fa.ACTOR_ID = A.ACTOR_ID
JOIN film F on fa.film_id = f.film_id;

#Show all films rented by customer Arun

SELECT F.TITLE ,C.NAME
FROM RENTAL R 
JOIN CUSTOMER C ON R.CUSTOMER_ID=R.CUSTOMER_ID
JOIN FILM F ON R.FILM_ID = F.FILM_ID
WHERE NAME = 'ARUN';

#Show customer name, film title, and rental date.

SELECT C.NAME,F.TITLE,R.RENTAL_DATE
FROM RENTAL R
JOIN FILM F ON R.FILM_ID=F.FILM_ID
JOIN CUSTOMER C ON R.CUSTOMER_ID=C.CUSTOMER_ID;

#Display all films and the actors who acted in them.

SELECT F.TITLE,A.FIRST_NAME,A.LAST_NAME
FROM FILM_ACTOR FA 
JOIN FILM F ON FA.FILM_ID=F.FILM_ID
JOIN ACTOR A ON FA.ACTOR_ID=A.ACTOR_ID;

#Show customer name and number of films they rented
use movie_rentel;
select c.name , count(r.rental_id) as no_films
from customer c 
join rental r on c.customer_id = r.customer_id
group by c.name;

#List films and how many times each film was rented

select f.title, count(r.rental_id) as no_times
from rental r
join film f on r.film_id = f.film_id
group by f.title;

#Show actors and how many films they acted in

select a.first_name , a.last_name , count(f.film_id) as no_of_film
from film_actor f
join actor a on f.actor_id = a.actor_id
group by f.actor_id,a.first_name , a.last_name;

#Find the customer who rented the most films

select c.name , count(r.rental_id) as no_films
from customer c 
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.name
order by no_films
limit 1;

#Show top 3 most rented films.

SELECT title, total_rentals
FROM (
    SELECT f.title,
           COUNT(r.rental_id) AS total_rentals,
           DENSE_RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS rnk
    FROM film f
    JOIN rental r ON f.film_id = r.film_id
    GROUP BY f.film_id, f.title
) t
WHERE rnk <= 3;


