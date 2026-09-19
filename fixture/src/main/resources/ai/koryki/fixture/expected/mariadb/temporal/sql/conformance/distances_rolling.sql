-- TEMPORAL.md normative examples as result assertions (java.time reference).
-- Uniform-rendering subset: distances + end functions render identically across
-- dialects. Clamping (month_add) and begin (month_begin) are deferred until the
-- DATE->TIMESTAMP type promotion (task #22) is fixed, since their rendering diverges.
SELECT
  TIMESTAMPDIFF(MONTH, DATE '2023-01-31', DATE '2023-03-31') AS whole_two
, TIMESTAMPDIFF(MONTH, DATE '2023-01-31', DATE '2023-03-30') AS not_complete_one
, TIMESTAMPDIFF(DAY, DATE '2023-03-01', DATE '2023-02-01') AS signed_minus28
, LAST_DAY(DATE '2024-02-10') AS end_leap
, LAST_DAY(MAKEDATE(YEAR(DATE '2024-05-20'), 1) + INTERVAL (QUARTER(DATE '2024-05-20') * 3 - 1) MONTH) AS end_q2
, LAST_DAY(MAKEDATE(YEAR(DATE '2024-05-20'), 1) + INTERVAL 11 MONTH) AS end_year
FROM
 check_temporal c