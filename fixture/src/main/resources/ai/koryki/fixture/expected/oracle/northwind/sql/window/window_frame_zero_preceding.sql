-- A frame bound of 0 is a real bound, not an absent one — 0 PRECEDING is valid SQL and means the
-- current row. It used to render as a bare PRECEDING, which every one of the eight dialects
-- rejects, because "no count" and "count is zero" were the same state in the model.
SELECT
  o.order_id
, sum(o.freight) OVER ( ORDER BY o.order_id ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING) AS window_sum
FROM
 orders o
WHERE
  o.customer_id = 'VINET'
ORDER BY
  o.order_id ASC