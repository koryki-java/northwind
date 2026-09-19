-- Running per-customer concatenation: an aggregate (string_agg) used as a window function.
-- Regression for the OVER clause surviving templated dialect overrides.
SELECT
  o.order_id
, o.customer_id
, o.ship_city
, string_agg(o.ship_city, ',') OVER (PARTITION BY o.customer_id ORDER BY o.order_id) AS cities
FROM
 orders o
WHERE
   o.customer_id = 'ALFKI'
  OR
   o.customer_id = 'ANATR'
ORDER BY
  o.order_id ASC