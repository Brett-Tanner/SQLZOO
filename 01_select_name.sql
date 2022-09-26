-- 1

SELECT name FROM world
WHERE name LIKE 'Y%';

-- 2

SELECT name FROM world
WHERE name LIKE '%y';

-- 3

SELECT name FROM world
WHERE name LIKE '%x%';

-- 4

SELECT name FROM world
WHERE name LIKE '%land';

-- 5

SELECT name FROM world
WHERE name LIKE 'C%ia';

-- 6

SELECT name FROM world
WHERE name LIKE '%oo%';

-- 7 Find the countries that have three or more a in the name

SELECT name FROM world
WHERE name LIKE '%a%a%a%';

-- 8 Find the countries that have "t" as the second character.

SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name;

-- 9 Find the countries that have two "o" characters separated by two others.

SELECT name FROM world
WHERE name LIKE '%o__o%';

-- 10 Find the countries that have exactly four characters.

SELECT name FROM world
WHERE name LIKE '____';

-- 11

SELECT name
FROM world
WHERE name = capital;

-- 12

SELECT name
FROM world
WHERE capital = CONCAT(name, ' city');

-- 13 Find the capital and the name where the capital includes the name of the country.

SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');

-- 14 Find the capital and the name where the capital is an extension of name of the country.

SELECT capital, name
FROM world
WHERE length(capital) > length(name)
AND capital LIKE CONCAT('%', name, '%');

-- 15 Show the name and the extension where the capital is an extension of name of the country.

SELECT name, REPLACE(capital, name, '')
FROM world
WHERE length(capital) > length(name)
AND capital LIKE CONCAT('%', name, '%');  