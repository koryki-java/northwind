-- The bug this exists for: count_distinct over an entity with a composite key. order_details is
-- keyed by (order_id, product_id); resolving the entity to the first key column alone answered 830
-- -- the number of ORDERS -- where the truth is 2155, silently, because every line of one order
-- collapsed into one.
-- count on the same entity keeps one key column on purpose, and is compared here: a key is never
-- null, so counting one column counts rows.
SELECT
  count(od.order_id) AS lines_counted
, COUNT(DISTINCT (od.order_id, od.product_id)) AS lines_distinct
FROM
 order_details od