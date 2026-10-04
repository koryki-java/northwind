-- a FETCH item's subquery correlated to the outer row -- the inner FILTER reaches back to c,
-- the outer alias, exactly as customers_with_ordercount does through a join instead
SELECT
  c.company_name
, (
   SELECT
     count(o.order_id)
   FROM
    orders o
   WHERE
     o.customer_id = c.customer_id
  ) AS order_count
FROM
 customers c