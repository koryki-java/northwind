SELECT
  p.product_name
, TO_CHAR(p.unit_price, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS unit_price_text
FROM
 products p