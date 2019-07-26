-- What's the most expensive listing? What else can you tell me about the listing?
SELECT
	*
FROM
    sfo_listings
ORDER BY price DESC
LIMIT 1

-- What neighbordhoods seem to be the most popular?
SELECT
    neighbourhood,
    count(*)
FROM
    sfo_listings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- What time of year is the cheapest time to go to your city? What about the busiest?
WITH
	cheap
AS(
	SELECT
		*
	FROM
		sfo_listings
	WHERE 
		price >= '0' AND price<= '100'
	ORDER BY price ASC
)
SELECT
	cheap.last_review
FROM
	cheap
ORDER BY last_review
LIMIT 1
-- What about the busiest?
SELECT
	*
FROM
	sfo_listings
ORDER BY number_of_reviews DESC
LIMIT 1





