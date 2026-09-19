SELECT
  c.company_name
, coalesce(c.region, 'N/A') AS region_or_default
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'