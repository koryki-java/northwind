-- A row limit on a branch of a set operation limits that branch, not the whole compound: the
-- first and the last branch are limited (and ordered, or the three rows would be any three), the
-- middle one is not. The customer ids are plain upper-case ASCII, so that every database sorts
-- them the same way and the three rows are the same ones everywhere.
SELECT * FROM (
  SELECT
    c1.customer_id AS id
  FROM
   customers c1
  WHERE
    c1.customer_id LIKE 'A%'
  ORDER BY
    c1.customer_id ASC
  OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS limited_branch
UNION
  SELECT
    c2.customer_id AS id
  FROM
   customers c2
  WHERE
    c2.customer_id LIKE 'B%'
UNION
SELECT * FROM (
 SELECT
   c3.customer_id AS id
 FROM
  customers c3
 WHERE
   c3.customer_id LIKE 'C%'
 ORDER BY
   c3.customer_id ASC
 OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS limited_branch