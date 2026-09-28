-- a FETCH item can itself be a whole FIND: an uncorrelated scalar subquery, the same total for
-- every row
SELECT
  c.company_name
, (
   SELECT
     count(o.order_id)
   FROM
    orders o
  ) AS order_count
FROM
 customers c