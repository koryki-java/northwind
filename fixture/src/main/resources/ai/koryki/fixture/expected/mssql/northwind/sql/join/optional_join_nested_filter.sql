-- Regression: a filter pushed onto a source nested below an optional join rendered
-- nowhere — collectInnerFilter skips the optional subtree for WHERE, and only the
-- optional source's own filter reached the ON clause. The nested filter must render
-- in its own join's ON clause.
SELECT
  c.company_name
, od.order_id
, od.quantity
FROM
 customers c
  LEFT OUTER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
    AND
     od.quantity > 100
ORDER BY
  c.company_name ASC
, od.order_id ASC