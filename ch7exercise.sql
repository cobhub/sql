-- Winter Olympics Gold Medals

-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.
-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.

select*
from winter_games;
select*
from countries;

-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.
WITH top_gold_winter as (
select countries.country, max(gold) as top_gold_medals
from winter_games
group by countries.country
)
-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.
select countries.country as country, t.top_gold_winter
from top_gold_winter as t
join winter_games as w
on t.country_id = w.id
group by countries;






select countries.country, count(winter_games.gold) as top_five
from winter_games
join countries
on winter_games.country_id = countries.id
where winter_games.gold is not null
group by countries.country
order by top_five desc
limit 5;
