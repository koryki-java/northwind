-- split_part: first dash-separated field of the phone.
SELECT
  split_part(c.phone, '-', 1) AS first_field
FROM
 customers c