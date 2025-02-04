SELECT*
FROM ecd;
-- question 1.a: 902
SELECT COUNT(county)
FROM ecd;
-- question 1.b: 88
SELECT COUNT(DISTINCT county)
FROM ecd;
-- question 2: 703
SELECT COUNT (company)
FROM ecd
WHERE ed IS NULL;
-- question 3: $12,634,623,829.00
SELECT SUM(capital_investment) AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap IS NOT NULL;
--question 4: 
SELECT county_tier,
   AVG(new_jobs) AS avg_numb_new_jobs
  FROM ecd
GROUP BY county_tier;
--question 5:
SELECT COUNT(DISTINCT company) AS llc_companies
FROM ecd;