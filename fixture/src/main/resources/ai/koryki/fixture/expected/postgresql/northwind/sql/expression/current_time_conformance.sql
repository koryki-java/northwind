-- today(), now() and clock_now() return a different value on every run, so their doc samples are
-- ignored on all eight dialects — which left them verified nowhere, and the CSV goldens beside them
-- asserting nothing: today's still carried the header of a query it no longer matched.
-- The values are not stable, but their relationships are, and those are what the engines must agree
-- on. This is the check the doc samples cannot be.
SELECT
  CASE WHEN EXTRACT(YEAR FROM CURRENT_DATE) >= 2026 THEN 'yes' ELSE 'no' END AS today_is_current
, CASE WHEN EXTRACT(YEAR FROM statement_timestamp()) = EXTRACT(YEAR FROM CURRENT_DATE) THEN 'yes' ELSE 'no' END AS now_agrees_with_today
, CASE WHEN EXTRACT(YEAR FROM clock_timestamp()) = EXTRACT(YEAR FROM CURRENT_DATE) THEN 'yes' ELSE 'no' END AS clock_now_agrees_with_today
FROM
 orders o
WHERE
  o.order_id = 10248