-- How many rows are in the athletes table? How many distinct athlete ids? 4,216
select count(*)
FROM athletes;
-- Which years are represented in the summer_games, winter_games, and country_stats tables?
select distinct year
from summer_games
union
select distinct year
from winter_games
union
select distinct year
from country_stats
order by year desc;

-- ALTER TABLE country_stats
-- ALTER COLUMN year TYPE DATE
-- USING year::DATE;
--used above function to change data type
-- ALTER TABLE country_stats
-- ALTER COLUMN pop_in_millions TYPE NUMERIC
-- USING pop_in_millions::NUMERIC;

-- How many distinct countries are represented in the countries and country_stats table? 203
select distinct(c1.country)
from countries as c1
inner join country_stats as c2
on c1.id = c2.country_id;

-- How many distinct events are in the winter_games and summer_games table? 32 & 95

from summer_games;
select count (distinct event)
from winter_games;

select count (distinct event)
from summer_games
union 
select count (distinct event)
from winter_games;

-- Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns.
select*
from summer_games;
select*
from athletes;
select*
from countries;

select a3.country as country,
count(distinct	a2.id) as num_of_athletes
from summer_games as a1
left join
athletes as a2
on a1.athlete_id = a2.id
left join countries as a3
on a1.country_id = a3.id
GROUP BY a3.country
ORDER BY num_of_athletes desc;
--this needs redone calling on countries table first and left joining the other tables since we want to ensure countries are returned regardless of the values, eg. 0 athletes

select country, count(distinct a3.id) as total athletes
from countries as a1
left join summer_games as a2
on a
--Did any country have no athletes? no






-- Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom.

select *
from countries;
select *
from summer_games;
select *
from winter_games;

select country, COALESCE(SUM(s.bronze), 0) + COALESCE(SUM(w.bronze), 0) AS total_bronze
from countries as c
left join summer_games as s
on c.id = s.country_id
left join winter_games as w
on c.id = w.country_id
where
group by country
order by total_bronze desc



-- Adjust the query to only return the country with the most bronze medals

select country, COALESCE(SUM(s.bronze), 0) + COALESCE(SUM(w.bronze), 0) AS total_bronze
from countries as c
left join summer_games as s
on c.id = s.country_id
left join winter_games as w
on c.id = w.country_id
group by country
order by total_bronze desc
LIMIT 1;

-- Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins.
-- First query gives you country names and the average population
-- Second query returns only countries that participated in the winter_games
select*
from country_stats;
select*
from winter_games;
select*
from countries;

SELECT country,AVG(pop_in_millions::numeric) as avg_pop
from country_stats
inner join winter_games
on country_stats.country_id = winter_games.country_id
inner join countries
on country_stats.country_id = countries.id
where pop_in_millions IS NOT NULL
and event IS NOT NULL
group by country
order by avg_pop desc


select

-- Identify countries where the population decreased from 2000 to 2006.

select*
from country_stats;

select country, a.year, a.pop_in_millions, b.year, b.pop_in_millions
from country_stats as a
join country_stats as b
on a.country_id = b.country_id
join countries
on a.country_id = countries.id
where a.year = '2000-01-01' and b.year = '2006-01-01'
and a.pop_in_millions > b.pop_in_millions




