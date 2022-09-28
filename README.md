# SQLZOO

## 00
- Remember strings should be in single quotes
- WHERE col IN () lets you provide a list to check if the col value is in it
- 7/7

## 01
- Cakewalk when you've learnt a bit of regex lol
- CONCAT(col, string) concatenates, weirdly enough
    - importantly, that lets you use col values in LIKE by concatenating them with '%'
- REPLACE(string, string to replace, string replacement)
    - does what the syntax says, you can pass col_names as long as they're strings

## 02
- **NO SPACES IN NUMBERS!!!**
- XOR is a thing, shows rows where one of the two conditions are true but not both
- length(col) gives you the length of the value in col
- can use <> as not equals in some SQL variants?
- 6/7 on the test
    - WHERE filters before any math in the select 

## 03
- You can escape single quotes (') by doing 2 of them (O''Neill)
- You can chain ORDER BY using commas
- IN () can be used as a value; it returns 1 if there's a match and 0 if not

## 04
- If you select a single value (in brackets), you can use that value as a value for something else
- You can use ALL after a comparison operator to compare the left side to all of a list of values
- If you use an alias for the tables in nested SELECTs, you can compare values from each of the tables
- For #10 I forgot to exclude the country itself from the list of countries it was being compared against, but got there in the end

## 05
- WHERE sorts stuff before GROUP BY, HAVING after they're grouped
- Means HAVING can't use original cols as conditions (unless you include them in the new table), can use SUM/COUNT etc. of them though

## 06
- Seems when you use GROUP BY you need to list all the non-aggregated cols in the order you want them to be grouped by

## 07
- You can use GROUP BY and HAVING even if none of the SELECTED cols are aggregate functions

## 08
- Remember you can use COALESCE() to return the first non-null value from list of values
- COUNT() ignores NULL
- In case, you can use OR to link conditions which have the same THEN value

## 09
- RANK() OVER(PARTITION BY col ORDER BY col) AS col_name
    - ranks the rows by the ORDER BY value in a new col
    - PARTITION BY groups by the col you provide
- LAG(col to lag, lag amount) OVER (PARTITION BY col ORDER BY col)
    - used to show data from preceding rows of the table
- LEAD(col to lead, lead amount) OVER (PARTITION BY col ORDER BY col)
    - used to show data from subsequent rows of the table
- You can use DAY(col), MONTH(col) and YEAR(col) to extract those values from a date value in a col
 - WEEKDAY(col) = 0 for Monday
- DATE_ADD(date, INTERVAL num week/day/month/yr)
    - Allows you to add number of interval to date
- DATE_FORMAT(date, template)
    - lets you format the date using the template
- WITH name AS (select statement)
    - lets you set a variable of name to be used in a subsequent SQL query