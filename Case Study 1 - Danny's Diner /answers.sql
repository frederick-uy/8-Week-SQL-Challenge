/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
SELECT
  sales.customer_id,
  SUM(menu.price)
FROM
  dannys_diner.sales AS sales
LEFT JOIN dannys_diner.menu AS menu
  ON sales.product_id = menu.product_id
 GROUP BY sales.customer_id
 ORDER BY  SUM(menu.price) DESC

-- 2. How many days has each customer visited the restaurant?
SELECT
  sales.customer_id,
  COUNT(DISTINCT sales.order_date)
FROM dannys_diner.sales AS sales
GROUP BY sales.customer_id
ORDER BY COUNT(DISTINCT sales.order_date) DESC

-- 3. What was the first item from the menu purchased by each customer?
WITH first_order AS (
    SELECT
      sales.customer_id,
      menu.product_name,
      MIN(sales.order_date) AS first_order_date
    FROM dannys_diner.sales AS sales
    LEFT JOIN dannys_diner.menu AS menu
      ON sales.product_id = menu.product_id
    GROUP BY sales.customer_id, menu.product_name
)
SELECT
  customer_id,
  product_name,
  first_order_date AS order_date
FROM first_order
ORDER BY first_order_date DESC;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT
  menu.product_name,
  COUNT(sales.product_id)
FROM
  dannys_diner.menu AS menu
LEFT JOIN dannys_diner.sales AS sales
  ON menu.product_id = sales.product_id
GROUP BY menu.product_name
LIMIT 1;

-- 5. Which item was the most popular for each customer?
SELECT
  sales.customer_id,
  menu.product_name,
  COUNT(sales.product_id)
FROM
  dannys_diner.sales AS sales
LEFT JOIN dannys_diner.menu AS menu
  ON menu.product_id = sales.product_id
GROUP BY menu.product_name, sales.customer_id


