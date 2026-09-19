-- TEMPORAL.md normative examples as result assertions (java.time reference).
-- Uniform-rendering subset: distances + end functions render identically across
-- dialects. Clamping (month_add) and begin (month_begin) are deferred until the
-- DATE->TIMESTAMP type promotion (task #22) is fixed, since their rendering diverges.
SELECT
  TRUNC(MONTHS_BETWEEN(DATE '2023-03-31', DATE '2023-01-31')) AS whole_two
, TRUNC(MONTHS_BETWEEN(DATE '2023-03-30', DATE '2023-01-31')) AS not_complete_one
, TRUNC(CAST(DATE '2023-02-01' AS DATE) - CAST(DATE '2023-03-01' AS DATE)) AS signed_minus28
, TRUNC(LAST_DAY(DATE '2024-02-10')) AS end_leap
, LAST_DAY(ADD_MONTHS(TRUNC(DATE '2024-05-20', 'Q'), 2)) AS end_q2
, LAST_DAY(ADD_MONTHS(TRUNC(DATE '2024-05-20', 'YYYY'), 11)) AS end_year
FROM
 check_temporal c