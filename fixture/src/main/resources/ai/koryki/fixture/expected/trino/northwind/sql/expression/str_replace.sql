SELECT
  replace(c.company_name, 'Futterkiste', 'GmbH') AS renamed
, replace(c.city, 'Berlin', 'München') AS city_renamed
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'