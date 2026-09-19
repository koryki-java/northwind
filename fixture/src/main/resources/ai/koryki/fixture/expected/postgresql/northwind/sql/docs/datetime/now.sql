-- now: the current timestamp.
SELECT
  statement_timestamp() AS current_ts
FROM
 orders o