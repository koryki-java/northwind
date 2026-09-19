-- coalesce: region, falling back to country.
SELECT
  coalesce(c.region, c.country) AS region_or_country
FROM
 customers c