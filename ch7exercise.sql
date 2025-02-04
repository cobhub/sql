-- Winter Olympics Gold Medals

-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.
-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.

select*
from winter_games;
select*
from countries;

-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.
-- WITH top_gold_winter as (
-- select c.country, max(gold) as top_gold_medals
-- from winter_games
-- join countries as c
-- on id = c.id
-- group by c.country
-- order by top_gold_medals desc
)
-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.
select countries.country as country, t.top_gold_winter
from top_gold_winter as t
join winter_games as w
on t.country_id = w.id
group by countries;





with top_gold_winter as
(select countries.country, count(winter_games.gold) as top_five
from winter_games
join countries
on winter_games.country_id = countries.id
where winter_games.gold is not null
group by countries.country
order by top_five desc
limit 5)
select*
from top_gold_winter
where top_five >= 5

-- Write a CTE called tall_athletes to find athletes taller than
--the average height for athletes in the database.
--Query the CTE to return only female athletes over age 30 who meet the
--criteria.

with tall_athletes as
(select name, age, gender, height, weight
from athletes
where height > (select avg(height)from athletes)
group by name, age, gender, height, weight
order by height)
select*
from tall_athletes
where gender = 'F' and age > 30;



-- Write a CTE called tall_over30_female_athletes for the results of Exercise 2.
-- Query the CTE to find the average weight of these athletes.
--174.9964421252371917
with tall_over30_female_athletes as 
(select name, age, gender, height, weight
from athletes
where height > (select avg(height)from athletes)
and gender = 'F' and age >30
group by name, age, gender, height, weight
order by height)
select round(avg(weight) * 2.2, 2) as rounded_weight_lbs
from tall_over30_female_athletes;
--avg weight: 72.22g 158.89lb