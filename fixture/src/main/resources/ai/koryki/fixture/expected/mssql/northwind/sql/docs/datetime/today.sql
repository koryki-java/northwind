-- today: the current date.
SELECT
  CAST(GETDATE() AS DATE) AS todays_date
FROM
 orders o