-- The only fixture compared in the order the engine returned it — CSVAssert sorts rows as text
-- unless the fixture name ends in "stable". That opt-out had never fired: it tested the file name,
-- which always ends in ".kql", so every fixture in the corpus was sorted before comparison and no
-- ORDER was verified anywhere. A dialect rendering ORDER BY wrongly, or dropping it, passed.
-- order_id is unique, so the ordering is total and cannot depend on how an engine breaks ties.
-- DESC is deliberate: text-sorted, these rows come out 10248 first, so a golden that still reads
-- 10252 first is proof the order survived rather than an accident of sorting.
SELECT
  o.order_id
, o.customer_id
FROM
 orders o
WHERE
  o.order_id < 10253
ORDER BY
  o.order_id DESC