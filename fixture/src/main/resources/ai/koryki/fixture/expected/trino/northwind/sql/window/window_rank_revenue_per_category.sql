-- test
WITH product_revenue (catname, prodname, revenue) AS (
SELECT
  c.category_name AS catname
, p.product_name AS prodname
, sum(od.unit_price * od.quantity) AS revenue
FROM
 orders o
  INNER JOIN order_details od ON
   o.order_id = od.order_id
    INNER JOIN products p ON
     od.product_id = p.product_id
      INNER JOIN categories c ON
       p.category_id = c.category_id
WHERE
  c.category_name = 'Beverages'
GROUP BY
  c.category_name
, p.product_name
)
SELECT
  pr.catname
, pr.prodname
, pr.revenue
, rank() OVER (PARTITION BY pr.catname ORDER BY pr.revenue DESC) AS rnk
FROM
 product_revenue pr
ORDER BY
  pr.catname ASC
, rank() OVER (PARTITION BY pr.catname ORDER BY pr.revenue DESC) ASC