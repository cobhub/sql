-- 1. Use a window function to add columns showing:
-- The maximum population (max_pop) for each county.
-- The minimum population (min_pop) for each county.

-- select*
-- from population;

select county,
population,
max(population) over() as max_pop,
min(population) over() as min_pop
from population;

-- Rank counties from largest to smallest population for each year.

select county,
population,
year,
rank() over(partition by year order by population desc) as county_pop
from population;

-- Use the unemployment table:
-- Calculate the rolling 12-month average unemployment rate using
--the unemployment table. Include the current month and the
--preceding 11 months. Hint: Reference two columns in the
--ORDER BY argument (county and period).

-- select*
-- from unemployment;

select county,
period_name,
round(avg(value)
over(partition by county
order by county, year, period
rows between 11 preceding and current row), 2) as rolling_rate
from unemployment
order by county, year, period;

