-- Find which county had the most months with unemployment rates above the state average:

-- Use Select to count the number of months each county was above the average. Which country had the most?

select*
from ecd;
select*
from population;
select*
from unemployment;
-- Write a query to calculate the state average unemployment rate. 7.10
select avg(avg_unemployment)
from(select county, avg(value) as avg_unemployment
from unemployment
group by county) as avg_unemp_rate;
-- Use this query in the WHERE clause of an outer query to filter for months above the average.
select period, value
from unemployment
where value > (select avg(avg_unemployment)
from(select county, avg(value) as avg_unemployment
from unemployment
group by county));
-- Use Select to count the number of months each county was above the average. Which country had the most?
select distinct county,count(county) as months_above_avg, value
from unemployment
where value > (select avg(avg_unemployment)
from(select county, avg(value) as avg_unemployment
from unemployment
group by county))
group by county, value
order by months_above_avg desc;

-- Find the average number of jobs created for each county based on projects involving the largest capital investment by each company:

select*
from ecd;
where company = 'Asurion, Inc.';
select*
from population;
select*
from unemployment;

-- Write a query to find each company’s largest capital investment, returning the company name along with the relevant capital investment amount for each.
select company, max(capital_investment) as max_capital_inv
from ecd
group by company
order by company asc;
-- Use this query in the FROM clause of an outer query, alias it, and join it with the original table.
-- Use Select * in the outer query to make sure your join worked properly
select *
from (select company,
max(capital_investment) as max_capital_inv
from ecd
group by company) as max_inv
inner join ecd
using (company);
-- Adjust the SELECT clause to calculate the average number of jobs created by county.
select county, avg(new_jobs) as avg_num_new_jobs
from (select company,
max(capital_investment) as max_capital_inv
from ecd
group by company) as max_inv
inner join ecd
using (company)
group by county
order by avg_num_new_jobs desc;