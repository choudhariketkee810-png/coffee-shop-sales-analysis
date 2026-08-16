-- ============================================================
-- COFFEE SHOP SALES ANALYSIS
-- Author: Ketkee Kokode
-- Tools: SQL | PostgreSQL / MySQL
-- ============================================================


-- ============================================================
-- 1. TOTAL REVENUE
-- ============================================================

SELECT 
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM coffee_shop_sales;


-- ============================================================
-- 2. TOTAL TRANSACTIONS
-- ============================================================

SELECT 
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_shop_sales;


-- ============================================================
-- 3. TOTAL QUANTITY SOLD
-- ============================================================

SELECT 
    SUM(transaction_qty) AS total_quantity_sold
FROM coffee_shop_sales;


-- ============================================================
-- 4. REVENUE BY STORE LOCATION
-- ============================================================

SELECT
    store_location,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY store_location
ORDER BY revenue DESC;


-- ============================================================
-- 5. TOP 10 PRODUCTS BY REVENUE
-- ============================================================

SELECT
    product_detail,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY product_detail
ORDER BY revenue DESC
LIMIT 10;


-- ============================================================
-- 6. TOP 10 PRODUCTS BY QUANTITY SOLD
-- ============================================================

SELECT
    product_detail,
    SUM(transaction_qty) AS quantity_sold
FROM coffee_shop_sales
GROUP BY product_detail
ORDER BY quantity_sold DESC
LIMIT 10;


-- ============================================================
-- 7. REVENUE BY PRODUCT CATEGORY
-- ============================================================

SELECT
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY product_category
ORDER BY revenue DESC;


-- ============================================================
-- 8. SALES BY DAY OF WEEK
-- ============================================================

SELECT
    DAYNAME(transaction_date) AS day_name,
    SUM(transaction_qty) AS quantity_sold,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY DAYNAME(transaction_date), DAYOFWEEK(transaction_date)
ORDER BY DAYOFWEEK(transaction_date);


-- ============================================================
-- 9. SALES BY HOUR
-- ============================================================

SELECT
    HOUR(transaction_time) AS sales_hour,
    SUM(transaction_qty) AS quantity_sold,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY HOUR(transaction_time)
ORDER BY sales_hour;


-- ============================================================
-- 10. PEAK SALES HOUR
-- ============================================================

SELECT
    HOUR(transaction_time) AS sales_hour,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY HOUR(transaction_time)
ORDER BY revenue DESC
LIMIT 1;


-- ============================================================
-- 11. MONTHLY SALES TREND
-- ============================================================

SELECT
    YEAR(transaction_date) AS sales_year,
    MONTH(transaction_date) AS sales_month,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY sales_year, sales_month;


-- ============================================================
-- 12. AVERAGE TRANSACTION VALUE
-- ============================================================

SELECT
    ROUND(
        SUM(transaction_qty * unit_price) /
        COUNT(DISTINCT transaction_id),
        2
    ) AS average_transaction_value
FROM coffee_shop_sales;


-- ============================================================
-- 13. STORE PERFORMANCE BY PRODUCT CATEGORY
-- ============================================================

SELECT
    store_location,
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue
FROM coffee_shop_sales
GROUP BY store_location, product_category
ORDER BY store_location, revenue DESC;


-- ============================================================
-- 14. PRODUCT WITH HIGHEST AVERAGE SELLING PRICE
-- ============================================================

SELECT
    product_detail,
    ROUND(AVG(unit_price), 2) AS average_price
FROM coffee_shop_sales
GROUP BY product_detail
ORDER BY average_price DESC
LIMIT 1;


-- ============================================================
-- 15. PRODUCTS CONTRIBUTING MOST TO REVENUE
-- ============================================================

SELECT
    product_detail,
    ROUND(SUM(transaction_qty * unit_price), 2) AS revenue,
    ROUND(
        100.0 * SUM(transaction_qty * unit_price) /
        (SELECT SUM(transaction_qty * unit_price)
         FROM coffee_shop_sales),
        2
    ) AS revenue_percentage
FROM coffee_shop_sales
GROUP BY product_detail
ORDER BY revenue DESC;
