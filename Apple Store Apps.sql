/* Exploring Apple Store Data */

-- Number of Unique Apps

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM AppleStore

-- Check for Missing Values

SELECT *
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

-- Number of Apps per Genre

SELECT prime_genre, COUNT(*) AS NumberApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumberApps DESC

-- App Ratings

SELECT MIN(user_rating) AS MinRating,
MAX(user_rating) AS MaxRating,
AVG(user_rating) AS AvgRating
FROM AppleStore

-- Do paid apps have higher ratings than free apps?

SELECT CASE 
WHEN price > 0 THEN 'Paid'
ELSE 'Free'
END AS App_Type,
AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY App_Type

-- Do apps with more supported languages have higher ratings?

SELECT CASE 
WHEN lang_num < 10 THEN '< 10 languages'
WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
ELSE '> 30 languages'
END AS language_amt,
AVG(user_rating) AS Avg_Rating
From AppleStore
ORDER BY language_amt
GROUP BY Avg_Rating DESC

-- Genres with Low Ratings

SELECT prime_genre, AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating

-- Top Rated Apps for Each Genre

SELECT prime_genre, track_name, user_rating
FROM (
    SELECT prime_genre, track_name, user_rating,
RANK() OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
FROM AppleStore) 
AS a 
WHERE
a.rank=1