CREATE DATABASE bike_store;

USE bike_store;

-- List all customers with their first name, last name, phone number, and city.

SELECT first_name , last_name , phone , city
FROM customers;


-- Show all products that cost more than $500.

SELECT product_name , list_price as 'Product Price'
FROM products
WHERE list_price > 500;


-- Display the first 10 customers sorted alphabetically by last name.

SELECT * 
FROM customers
ORDER BY last_name DESC
LIMIT 10;


-- Show all orders placed in the year 2017.

SELECT * 
FROM orders
WHERE YEAR(shipped_date) = 2017;


-- List all stores and their phone numbers.

SELECT store_name,phone
FROM stores;


-- Fetch the product names that belong to the brand Trek.

SELECT product_name , brand_name
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
WHERE brand_name = 'Trek';


-- Count how many products exist in the database.

SELECT COUNT(*) as 'Product Count'
FROM products;


-- Show the details of products where stock is less than 5.

SELECT product_name , quantity
FROM products p 
JOIN stocks s ON p.product_id = s.product_id
WHERE quantity < 5;


-- Display unique product categories.

SELECT DISTINCT * 
FROM categories;


-- Retrieve order details with customer name, order ID, order date, and store name.

SELECT first_name , last_name , order_id , order_date , store_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN stores s ON o.store_id = s.store_id;


-- List customers and the total number of orders they have placed.

SELECT c.customer_id,CONCAT(c.first_name, ' ', c.last_name) AS customer_name,COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_orders DESC;


-- Show the top 5 most expensive products.

SELECT product_name , list_price
FROM products 
ORDER BY list_price DESC
LIMIT 5 ;


-- Find the total sales amount per store.

SELECT store_name , round(SUM(oi.list_price*oi.quantity),2) as 'Total sales amount'
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY store_name;


-- List each employee and how many orders they handled.

SELECT CONCAT(s.first_name,' ',s.last_name) as 'employee_name' , COUNT(o.staff_id) as 'handled_customers'
FROM staffs s 
JOIN orders o ON s.staff_id = o.staff_id
GROUP BY o.staff_id , employee_name
ORDER BY handled_customers DESC;


-- Show brands and how many products each brand offers.

SELECT brand_name , COUNT(p.brand_id) as 'Total Product'
FROM brands b 
JOIN products p ON b.brand_id = p.brand_id
GROUP BY b.brand_name;


-- Display products with their category names and brand names.

SELECT product_name , category_name , brand_name
FROM categories c 
JOIN products p ON c.category_id = p.category_id
JOIN brands b ON p.brand_id = b.brand_id;


-- Find customers who placed more than 3 orders.

SELECT CONCAT(c.first_name,' ',c.last_name) as 'customer_name' , COUNT(oi.quantity) as 'total orders'
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id 
GROUP BY oi.quantity , customer_name
HAVING COUNT(oi.quantity) > 3;


-- Show the total quantity ordered for each product.

SELECT product_name , COUNT(quantity)  as total_order
FROM products p 
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY product_name;


-- Show the average product price per category.

SELECT category_name , ROUND(AVG(list_price),2) as 'Average Price'
FROM categories c 
JOIN products p ON c.category_id = p.category_id
GROUP BY category_name;


-- Display store name and total revenue grouped by store and sorted by revenue (descending).

SELECT s.store_name , ROUND(SUM(oi.quantity*oi.list_price),2) as 'Total Revenue '
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY SUM(oi.quantity*oi.list_price) DESC ;


-- Find customers who have never placed an order.

SELECT c.first_name ,c.last_name, o.customer_id
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


-- List the top 3 most sold products.

SELECT product_name , SUM(oi.quantity) as total_product_sold
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id
GROUP BY product_name 
ORDER BY total_product_sold DESC
LIMIT 3;


-- For each brand, show the minimum and maximum product price.

SELECT brand_name , MAX(list_price) as maximum_price , MIN(list_price) as minimun_price
FROM brands b 
JOIN products p ON b.brand_id = p.brand_id
GROUP BY brand_name;


-- Show all orders processed by a specific employee (example: employee_id = 3).

SELECT o.order_id,o.order_date,CONCAT(s.first_name, ' ', s.last_name) AS employee_name,o.customer_id,o.store_id
FROM orders o
JOIN staffs s ON o.staff_id = s.staff_id
WHERE o.staff_id = 3;


-- Find the second most expensive product.

SELECT product_name, list_price
FROM products
WHERE list_price = (
    SELECT DISTINCT list_price
    FROM products
    ORDER BY list_price DESC
    LIMIT 1 OFFSET 1
);


-- List customers who spent more than the average spending of all customers.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(oi.list_price * oi.quantity),2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name
HAVING total_spent > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(oi2.list_price * oi2.quantity) AS customer_total
        FROM customers c2
        JOIN orders o2 ON c2.customer_id = o2.customer_id
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        GROUP BY c2.customer_id
    ) AS avg_table
);


-- Show the top 5 loyal customers based on total orders placed .

SELECT CONCAT(first_name,' ',last_name) as customer_name , COUNT(oi.order_id) as total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id 
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY customer_name
ORDER BY total_orders DESC 
LIMIT 5;

-- Rank brands based on average product price.

SELECT b.brand_name , ROUND(AVG(p.list_price),2) as avg_product_price , RANK() OVER(ORDER BY ROUND(AVG(p.list_price),2) DESC) as rank_by_average_product_price
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name;

-- Create a CTE to calculate total revenue and display customers sorted by revenue.

WITH customer_revenue as (
	SELECT CONCAT(c.first_name,' ', c.last_name) as customer_name, ROUND(SUM(oi.list_price*oi.quantity),2)as total_revenue
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    GROUP BY c.customer_id,customer_name
)
SELECT * 
FROM customer_revenue
ORDER BY total_revenue DESC;

-- Find employees who processed more orders than the average of all employees.

SELECT CONCAT(s.first_name,' ', s.last_name) as employee_name , COUNT(o.staff_id)
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
GROUP BY o.staff_id , employee_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(order_id) AS order_count
        FROM orders
        GROUP BY staff_id
    ) AS avg_table
);

-- Show the most popular product category based on total sold quantity.

SELECT category_name ,SUM(oi.quantity) as total_quantity_sold
FROM categories c 
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY category_name
ORDER BY total_quantity_sold DESC;


-- List customers whose first order happened in 2017.

SELECT CONCAT(first_name , ' ' , last_name) as customer_name , order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id 
WHERE YEAR(order_date) = '2017'
ORDER BY order_date;


-- Find the best-selling employee per store.

SELECT store_name , CONCAT(first_name,' ',last_name) as employee_name, 
	COUNT(o.staff_id) as total_orders , 
    RANK() OVER(PARTITION BY store_name ORDER BY COUNT(o.staff_id) DESC ) as rank_in_store
FROM staffs s 
JOIN orders o ON s.staff_id = o.staff_id
JOIN stores ss ON o.store_id = ss.store_id
GROUP BY ss.store_name, employee_name
ORDER BY ss.store_name, rank_in_store;

-- Show products that were never purchased.

SELECT p.product_name
FROM products p
LEFT JOIN order_items oi 
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- Fetch the latest order made by each customer.
WITH latest_orders AS (
    SELECT c.customer_id,CONCAT(c.first_name, ' ', c.last_name) AS customer_name,o.order_date , ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS rn
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
)
SELECT customer_name, order_date
FROM latest_orders
WHERE rn = 1
ORDER BY order_date DESC;



