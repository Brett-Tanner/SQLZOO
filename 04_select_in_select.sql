-- 1 List each country name where the population is larger than that of 'Russia'

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2

SELECT name FROM world
  WHERE continent = 'Europe' AND gdp / population > 
    (SELECT gdp / population FROM world
    WHERE name = 'United Kingdom');

-- 3

SELECT name, continent FROM world
  WHERE continent = 
    (SELECT continent FROM world
    WHERE name = 'Australia')
  XOR continent =
    (SELECT continent FROM world
    WHERE name = 'Argentina')
  ORDER BY name;

-- 4

SELECT name, population FROM world
  WHERE population >
    (SELECT population FROM world
    WHERE name = 'United Kingdom')
  AND population <
    (SELECT population FROM world
    WHERE name = 'Germany');

-- 5 Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(
  ROUND(population * 100 / 
    (SELECT population 
    FROM world 
    WHERE name = 'Germany')), 
  '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 6

SELECT name FROM world
  WHERE gdp > ALL (SELECT gdp
                  FROM world
                  WHERE gdp > 0 AND continent = 'Europe');

-- 7 Find the largest country (by area) in each continent, show the continent, the name and the area: 

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);

-- 8 List each continent and the name of the country that comes first alphabetically.

SELECT continent, 
  (SELECT name FROM world y
  WHERE x.continent = y.continent
  ORDER BY name LIMIT 1)
FROM world x
GROUP BY continent;

-- 9 Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. 

SELECT name, continent, population FROM world
  WHERE continent IN
  (SELECT continent FROM world AS x
    WHERE 25000000 >= ALL (SELECT population FROM world AS y
                            WHERE x.continent = y.continent)
                          GROUP BY continent);

-- 10 Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world AS x
WHERE population > ALL (SELECT population * 3 FROM world AS y
                       WHERE x.continent = y.continent
                       AND y.name != x.name);