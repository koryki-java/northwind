-- The counterpart to timestamp_between: an upper bound with a time the author chose. It must stay
-- literal and inclusive. Every TIMESTAMP upper bound used to be widened to the next midnight, so
-- this query silently covered until 2023-01-01 00:00 — seven hours more than it asks for.
SELECT
  o.order_id
, o.delivered_date
FROM
 orders o
WHERE
  o.delivered_date BETWEEN TIMESTAMP '2022-07-01 00:00:00' AND TIMESTAMP '2022-12-31 17:00:00'