-- CROSS pairs every row with every row and takes no condition: every shipper with every category.
-- The marker stands where + stands, and it is written without VIA and without columns.
SELECT
  COUNT(*) AS pairs
FROM
 shippers s
  CROSS JOIN categories c