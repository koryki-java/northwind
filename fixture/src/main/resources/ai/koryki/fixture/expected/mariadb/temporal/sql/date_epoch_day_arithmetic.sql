-- DATE stored as a day-count since 1970 (DATE_FROM_EPOCH_DAY) + duration: arithmetic materializes the
-- epoch-day to a date first, then applies the duration (a clock component promotes to TIMESTAMP).
SELECT
  c.date_epoch_day AS date_epoch_day
, (DATE '1970-01-01' + INTERVAL c.date_epoch_day DAY) - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '30' MINUTE - INTERVAL '10' SECOND AS minus_1day90min10seconds
FROM
 check_temporal c