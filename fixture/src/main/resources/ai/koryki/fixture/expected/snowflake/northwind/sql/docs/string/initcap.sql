-- initcap: title-case the contact name.
SELECT
  initcap(c.contact_name) AS titled
FROM
 customers c