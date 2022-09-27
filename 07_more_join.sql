-- 1

SELECT id, title
 FROM movie
 WHERE yr=1962;

-- 2

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4

SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5

SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6

SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 11768;

-- 7

SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
  JOIN movie on casting.movieid = movie.id
WHERE movie.title = 'Alien';

-- 8

SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 9

SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
AND casting.ord != 1;

-- 10

SELECT movie.title, actor.name
FROM movie JOIN casting on movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962
AND casting.ord = 1;

-- 11

SELECT yr, COUNT(title) AS movies_made FROM
  movie JOIN casting ON movie.id = casting.movieid
        JOIN actor   ON casting.actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12

SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
  WHERE actorid IN (
    SELECT id FROM actor
    WHERE name='Julie Andrews'))
AND casting.ord = 1;


-- 13 Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(actor.name) >= 15;

-- 14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT movie.title, COUNT(actor.name) AS num_actors
FROM movie JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE yr = 1978
GROUP BY movie.title
ORDER BY num_actors DESC, movie.title;

-- 15 List all the people who have worked with 'Art Garfunkel'. 

SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
  JOIN movie ON casting.movieid = movie.id
WHERE movie.id IN (
  SELECT movie.id
  FROM movie JOIN casting ON movie.id = casting.movieid
    JOIN actor ON casting.actorid = actor.id
  WHERE actor.name = 'Art Garfunkel')
AND actor.name != 'Art Garfunkel';