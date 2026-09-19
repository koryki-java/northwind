-- TEMPORAL.md normative examples as result assertions (java.time reference).
-- Uniform-rendering subset: distances + end functions render identically across
-- dialects. Clamping (month_add) and begin (month_begin) are deferred until the
-- DATE->TIMESTAMP type promotion (task #22) is fixed, since their rendering diverges.
SELECT
  (DATEDIFF(month, DATE '2023-01-31', DATE '2023-03-31') - CASE WHEN DAY(DATE '2023-03-31') < DAY(DATE '2023-01-31') THEN 1 ELSE 0 END) AS whole_two
, (DATEDIFF(month, DATE '2023-01-31', DATE '2023-03-30') - CASE WHEN DAY(DATE '2023-03-30') < DAY(DATE '2023-01-31') THEN 1 ELSE 0 END) AS not_complete_one
, TRUNC(DATEDIFF(second, DATE '2023-03-01', DATE '2023-02-01') / 86400) AS signed_minus28
, last_day(DATE '2024-02-10') AS end_leap
, LAST_DAY(DATE '2024-05-20', 'quarter') AS end_q2
, LAST_DAY(DATE '2024-05-20', 'year') AS end_year
FROM
 check_temporal c