-- split_part: first dash-separated field of the phone.
SELECT
  SUBSTRING_INDEX(SUBSTRING_INDEX(c.phone, '-', 1), '-', -1) AS first_field
FROM
 customers c