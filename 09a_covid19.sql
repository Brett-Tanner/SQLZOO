-- 1

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

-- 2 Modify the query to show confirmed for the day before.

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS yesterday_confirmed
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

-- 3

SELECT name, DAY(whn),
   confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

-- 4 Show the number of new cases in Italy for each week in 2020 - show Monday only.

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0 AND YEAR(whn) = 2020
ORDER BY whn;

-- 5 Show the number of new cases in Italy for each week - show Monday only

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 tw.confirmed - lw.confirmed AS weekly_confirmed
 FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 6

SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) AS rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) AS rd
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

-- 7 Show the infect rate ranking for each country. Only include countries with a population of at least 10 million.

SELECT 
   world.name,
   ROUND(100000*confirmed/population,0) AS infect_rate,
   RANK() OVER (ORDER BY ROUND(100000*confirmed/population,0) DESC) AS infect_rank
  FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY infect_rank;

-- 8 For each country that has had at least 1000 new cases in a single day, show the date of the peak number of new cases.

-- make a list of the daily case increases and save as a variable, then find the max of the daily case counts for each country from case counts where there were at least 1000 extra daily cases
WITH temp1 AS (
  SELECT *, (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) day_count
  FROM covid
), temp2 AS (
  SELECT name, MAX(day_count) peak_cases
  FROM temp1
  GROUP BY name
  HAVING peak_cases > 1000
)
-- join those two lists, then display name/date/peak_cases
SELECT temp2.name, DATE_FORMAT(whn, '%Y-%m-%d') date, peak_cases
FROM temp2 LEFT JOIN temp1 ON (temp2.name = temp1.name) AND (temp2.peak_cases = temp1.day_count)
ORDER BY date;