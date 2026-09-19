-- lag/lead carry an optional offset and an optional default, both declared in the catalog and
-- neither exercised anywhere — the corpus only ever called them with one argument. The default is
-- what the first (or last) rows of a partition get, where there is no neighbour to read.
SELECT
  o.order_id
, lag(o.freight, 2, 0) OVER ( ORDER BY o.order_id) AS two_back
, lead(o.freight, 2, 0) OVER ( ORDER BY o.order_id) AS two_ahead
FROM
 orders o
WHERE
  o.order_id < 10253
ORDER BY
  o.order_id ASC