-- position: position of a dash within the phone.
SELECT
  POSITION('-' IN c.phone) AS dash_pos
FROM
 customers c