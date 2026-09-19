-- log: logarithm to an explicit base — the base comes first.
-- T-SQL takes LOG(value, base), the other way round from every other engine, so this
-- pins the value rather than just the rendering: log(2, 8) must be 3 everywhere.
SELECT
  o.order_id
, LOG(8, 2) AS log_base_two
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY