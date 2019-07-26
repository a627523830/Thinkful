-- What are the three longest trips on rainy days?
WITH 
	rainy 
AS
  (SELECT
 	 Date
  	FROM weather
 	WHERE events = 'Rain'
  	GROUP BY 1)
SELECT
  trip_id,
  duration,
  start_date
FROM
  trips
JOIN
  rainy
ON
  rainy.Date = start_date
ORDER BY duration DESC
LIMIT 3

-- Which station is full most often?
SELECT
  status.station_id,
  stations.name,
  COUNT(CASE WHEN docks_available=0 THEN 1 END) empty_count
FROM
  status
JOIN
  stations
ON
  stations.station_id = status.station_id
GROUP BY 1, 2
ORDER BY empty_count DESC

-- Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
SELECT
  start_station,
  dockcount,
  count(*)
FROM
  trips
JOIN
  stations
ON
  stations.name = trips.start_station
GROUP BY 1, 2
ORDER BY 2 DESC

-- (Challenge) What's the length of the longest trip for each day it rains anywhere?
WITH rainy as 
(
SELECT 
DATE(date) weather_date
From weather
WHERE events = 'Rain'
GROUP BY 1
),
rain_trips as (
SELECT
trip_id,
duration,
DATE(trips.start_date) rain_trips_date
FROM trips
JOIN rainy
on rainy.weather_date = DATE(trips.start_date)
ORDER BY duration DESC
)
SELECT 
rain_trips_date,
max(duration) max_duration
from rain_trips
GROUP BY 1
ORDER BY max_duration DESC