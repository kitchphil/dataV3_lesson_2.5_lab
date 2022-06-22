use sakila;

#1 Select all the actors with the first name ‘Scarlett’.
SELECT 
	*
FROM
	sakila.actor
WHERE
	first_name = 'Scarlett'
;


#2 How many films (movies) are available for rent and how many films have been rented?

SELECT
	*
FROM
	(SELECT
		'Available For Rent' AS ''
		, COUNT(Distinct sakila.inventory.film_id) As 'No.'
	FROM
		sakila.inventory
	LIMIT
		1
	) AS T1
UNION
SELECT
	*
FROM
	(SELECT
		'Have Been Rented' AS ''
		, count(sakila.rental.rental_id) AS 'No.'
	FROM
		sakila.rental
	LIMIT
		1
	) AS T2
;


#3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT
	*
FROM
	(SELECT
		'max_duration' AS ''
		, sakila.film.title 
		, sakila.film.length
	FROM
		sakila.film
	ORDER BY
		sakila.film.length desc
	LIMIT
		1
	) AS T1
UNION
SELECT
	*
FROM
	(SELECT
		'min_duration' AS ''
		, sakila.film.title AS min_duration
		, sakila.film.length
	FROM
		sakila.film
	ORDER BY
		sakila.film.length asc
	LIMIT
		1
	) AS T2
;


-- OR --

SELECT
	max(sakila.film.length) AS max_duration
	, min(sakila.film.length) AS min_duration
FROM
	sakila.film
;


#4 What's the average movie duration expressed in format (hours, minutes)?

SELECT
	CONVERT(AVG(sakila.film.length),time) AS 'Hrs/Mins'
FROM
	sakila.film
;



#5 How many distinct (different) actors' last names are there?

SELECT  
	COUNT(DISTINCT sakila.actor.last_name)
FROM
	sakila.actor
;


#6 Since how many days has the company been operating (check DATEDIFF() function)?

SELECT 
    DATEDIFF(max(sakila.rental.rental_date),
		min(sakila.rental.rental_date)) AS Days
FROM
	sakila.rental 
;



#7 Show rental info with additional columns month and weekday. Get 20 results.

SELECT 
	*
    , date_format(CONVERT(left(rental_date,23),date), '%M') AS 'Month'
    , date_format(CONVERT(left(rental_date,23),date), '%W') AS 'Weekday'
FROM 
	sakila.rental 
LIMIT 
	20
;



#8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT 
	*
    , date_format(CONVERT(left(rental_date,23),date), '%M') AS 'Month'
    , date_format(CONVERT(left(rental_date,23),date), '%W') AS 'Weekday'
	, CASE
		WHEN 'Weekday' LIKE 'Mon%' then 'Week'
		WHEN 'Weekday' LIKE 'Tues%' then 'Week'
		WHEN 'Weekday' LIKE 'Wednes%' then 'Week'
		WHEN 'Weekday' LIKE 'Thurs%' then 'Week'
		WHEN 'Weekday' LIKE 'Fri%' then 'Week'
		ELSE 'Weekend'
        END AS 'day_type'
FROM 
	sakila.rental 
LIMIT 
	20
;



#9 Get release years.

SELECT DISTINCT
	sakila.film.release_year
FROM
	sakila.film
;


#10 Get all films with ARMAGEDDON in the title.

SELECT
	sakila.film.title
FROM
	sakila.film
WHERE
	title LIKE '%ARMAGEDDON%'
;


#11 Get all films which title ends with APOLLO.

SELECT
	sakila.film.title
FROM
	sakila.film
WHERE
	title LIKE '%APOLLO'
;


#12 Get 10 the longest films.

SELECT
	sakila.film.title  AS 'TOP 10 Longest Films'
FROM
	sakila.film
ORDER BY
	sakila.film.length DESC
LIMIT
	10
;


#13 How many films include Behind the Scenes content?

SELECT 
	COUNT(*) AS 'Films with BtS Content' 
FROM
	sakila.film
WHERE 
	sakila.film.special_features 
LIKE 
	'%Behind the Scenes'    
;