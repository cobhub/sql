--Generate to query this output:
-- Display Country name, 4-digit year, count of Nobel prize winners (where the count is ≥ 1), and country size:
-- Large: Population > 100 million
-- Medium: Population between 50 and 100 million (inclusive)
-- Small: Population < 50 million
-- Sort results so that the country and year with the largest number of Nobel prize winners appear at the top.
-- Export the results as a CSV file.
-- Use Excel to create a chart effectively communicating the findings.

SELECT*
FROM countries;
SELECT*
FROM country_stats;

SELECT c1.country,
CAST(date_part('year', c2.year::date) AS TEXT) as calendar_year,
c2.nobel_prize_winners,
c2.pop_in_millions,
CASE
WHEN CAST(c2.pop_in_millions AS NUMERIC) > 100 THEN 'Large'
WHEN CAST(c2.pop_in_millions AS NUMERIC) BETWEEN 50 AND 100 THEN 'Medium'
WHEN CAST(c2.pop_in_millions AS NUMERIC) < 50 THEN 'Small'
ELSE 'Zero'
END AS country_size
FROM countries AS c1
JOIN country_stats AS c2
ON c1.id = c2.country_id
WHERE c2.nobel_prize_winners >= 1
GROUP BY c1.country,
c2.year,
c2.nobel_prize_winners,
c2.pop_in_millions
ORDER BY c2.nobel_prize_winners DESC,
c2.year DESC;

-- Create the output below that shows a row for each country and
--each year. Use COALESCE() to display unknown when the gdp is NULL.


select*
from countries;
select*
from country_stats;

-- select ltrim(c1.country)as country,
-- cast(date_part('year', c2.year::date) as TEXT) as calendar_year,
-- coalesce (to_char(c2.gdp, '$999,999,999,999.00'), 'unknown') as gdp_amount
-- from countries as c1
-- join country_stats as c2
-- on c1.id = c2.country_id
-- where c1.country = 'AFG - Afghanistan'
-- group by c1.country, c2.year, c2.gdp
-- order by c1.country asc;
--mine

--ava's (neater, concise!)
select country,
year::character(4)::text,
coalesce(gdp::numeric::money::text, 'unknown') as gdp_amount
from countries
join country_stats
on id = country_id
where country = 'AFG - Afghanistan';








