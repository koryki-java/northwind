-- count_distinct over a window: distinct customers per country, alongside each customer, without
-- collapsing the rows. Only four engines allow DISTINCT inside a window aggregate; the other four
-- mark the function windowUnsupported and refuse at transpile time (see CountDistinctWindowTest).
SELECT
  c.customer_id
, c.country
, COUNT(DISTINCT c.customer_id) OVER (PARTITION BY c.country) AS per_country
FROM
 customers c
WHERE
  c.country = 'France'