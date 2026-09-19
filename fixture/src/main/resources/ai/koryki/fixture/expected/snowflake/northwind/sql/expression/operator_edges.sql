-- Three cases the first block of fixes repaired, each silently wrong or invalid on some dialect:
--   mod with an arithmetic left operand — SQL Server dropped the parentheses and computed
--     10248 - (8 % 7) = 10247 instead of 6.
--   negating a multi-component duration — -2d4h bound the minus to the first part only, giving
--     -2d + 4h, eight hours off, without an error. Needs a TIMESTAMP: adding an hours component
--     to a DATE is refused outright by Trino and several others.
--   round with one argument — SQL Server's ROUND requires at least two arguments.
SELECT
  mod(o.order_id - 8, NULLIF(7, 0)) AS m
, o.delivered_date + INTERVAL '-2 day, -4 hour' AS shifted
, round(o.freight) AS rounded
FROM
 orders o
WHERE
  o.order_id = 10248