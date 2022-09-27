-- 1

SELECT SUM(population)
FROM world;

-- 2

SELECT DISTINCT continent FROM world;

-- 3

SELECT SUM(gdp) AS total_gdp
FROM world
WHERE continent = 'Africa';

-- 4

SELECT COUNT(*) AS big_countries
FROM world
WHERE area >= 1000000;

-- 5

SELECT SUM(population) AS baltic_population
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6

SELECT continent, COUNT(name) AS countries
FROM world
GROUP BY continent;

-- 7

SELECT continent, COUNT(name) AS big_countries
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;