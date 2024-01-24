USE sakila;

-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) as max_duration, MIN(length) as min_duration FROM film; 

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT * FROM film;
SELECT AVG(length) FROM film;
SELECT FLOOR(AVG(length)/60) AS hours, 
ROUND(AVG(length) - FLOOR(AVG(length)/60)*60) AS minutes FROM film; 

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to 
-- subtract the earliest date in the rental_date column from the latest date.
SELECT * FROM rental;
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS nb_day_ops FROM rental;

-- 2.2 Retrieve rental information and add two additional columns 
-- to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date, '%M') AS month ,DATE_FORMAT(rental_date, '%W') AS weekday 
FROM rental 
-- ORDER BY rental_date ASC
LIMIT 20;

SELECT *, DATE_FORMAT(rental_date, '%M') AS month ,DAYNAME(rental_date) AS weekday 
FROM rental 
-- ORDER BY rental_date ASC
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column 
-- called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *, CASE 
WHEN DATE_FORMAT(rental_date,'%w') BETWEEN 1 AND 5 THEN 'workday'
ELSE 'weekend'
END AS day_type
FROM rental;

SELECT *, CASE 
WHEN DATE_FORMAT(rental_date,'%W') IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'workday'
ELSE 'weekend'
END AS day_type
FROM rental;

SELECT *, CASE 
WHEN DAYNAME(rental_date) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'workday'
ELSE 'weekend'
END AS day_type
FROM rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, 
-- the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title,IFNULL(rental_duration,'Not Available') AS rental_duration FROM film 
ORDER BY title ASC;

-- 4.Bonus: The marketing team for the movie rental company now needs to 
-- create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers
-- , along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name,' ',last_name) AS full_name, LEFT(email,3) 
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection 
-- to gain some more insights. Using the film table, determine:
SELECT * FROM film;
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS nb_film FROM film;
-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) nb_film FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings 
-- and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) nb_film FROM film
GROUP BY rating
ORDER BY nb_film DESC;












