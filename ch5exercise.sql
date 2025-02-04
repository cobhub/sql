-- Find Athletes from Summer or Winter Games
-- Write a query to list all athlete names who participated in the Summer or Winter Olympics. Ensure no duplicates appear in the final table using a set theory clause.
select*
from summer_games;

select athlete_id, name, 'Summer' as season
from athletes
inner join summer_games
on athletes.id = summer_games.athlete_id
union
select athlete_id, name, 'Winter' as season
from athletes
inner join winter_games
on athletes.id = winter_games.athlete_id;


-- Find Countries Participating in Both Games
select*
from countries;
select*
from summer_games;
select*
from country_stats;
-- Write a query to retrieve country_id and country_name for countries in the Summer Olympics.




-- Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement.
-- Repeat the process for the Winter Olympics.
-- Use a set theory clause to combine the results.

select distinct countries.country, pop_in_millions, country_stats.year
from summer_games
left join countries
on summer_games.country_id = countries.id
left join country_stats
on country_stats.country_id = summer_games.country_id
where country_stats.year between '2016-01-01' and '2016-12-31'
and pop_in_millions IS NOT NULL
intersect
select distinct countries.country, pop_in_millions, country_stats.year
from winter_games
left join countries
on winter_games.country_id = countries.id
left join country_stats
on country_stats.country_id = winter_games.country_id
where country_stats.year between '2016-01-01' and '2016-12-31'
and pop_in_millions IS NOT NULL
group by countries.country,pop_in_millions, country_stats.year
order by pop_in_millions desc;


select*
from countries;
select country_id
from summer_games
order by country_id asc;
select country_id
from winter_games
order by country_id asc;
-- Identify Countries Exclusive to the Summer Olympics
select country_id, countries.country, countries.region
from summer_games
left join countries
on summer_games.country_id = countries.id
except
select country_id, countries.country, countries.region
from winter_games
left join countries
on winter_games.country_id = countries.id
order by country_id;
-- Return the country_name and region for countries present in the countries table but not in the winter_games table.
-- (Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)
select id
from countries
where id is not null
order by id asc;
select country_id
from winter_games
where country_id is not null
group by country_id
order by country_id asc;

select id,country, region
from countries
except
select c.id,c.country, c.region
from countries as c
join winter_games as w
on c.id = w.country_id;



