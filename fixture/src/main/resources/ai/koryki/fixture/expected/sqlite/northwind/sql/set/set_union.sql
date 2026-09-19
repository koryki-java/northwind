 SELECT
   c.contact_name AS cn
 FROM
  customers c
 WHERE
   c.contact_name LIKE 'a%'
UNION
 SELECT
   c.contact_name AS cn
 FROM
  customers c
 WHERE
   c.contact_name LIKE 'b%'