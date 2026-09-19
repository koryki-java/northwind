-- A fetch item may carry a display label after its alias: `alias "Label"`. It names the column for
-- a reader without renaming it for the query -- the alias stays the identifier, the label is what a
-- UI shows. It reaches no SQL, which is why losing it went unnoticed: KQLFormatter dropped it while
-- IQLSerializer kept it, and the round-trip compares the generated SQL.
SELECT
  o.order_id AS id
, o.freight AS cost
FROM
 orders o
WHERE
  o.order_id < 10250
ORDER BY
  o.freight DESC