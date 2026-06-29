-- ============================================================
-- 03 : Business Analysis
-- ============================================================

-- ----------------------------------------------------------------
-- Analysis 1: Sales Performance
-- ----------------------------------------------------------------

-- Q1. What is the overall sales performance of the business?
SELECT
    ROUND(SUM(revenue_usd), 2)  AS total_revenue_usd,
    COUNT(*)                    AS transactions,
    SUM(units_sold)             AS total_units_sold,
    ROUND(AVG(revenue_usd), 2)  AS avg_order_value_usd
FROM apple_sales;

-- Q2. What are the quarterly trends in revenue and units sold from 2022 to 2024?
SELECT
	year, 
    quarter,
    SUM(units_sold)             AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)  AS total_revenue_usd
FROM apple_sales
GROUP BY year, quarter
ORDER BY year, FIELD(quarter, 'Q1', 'Q2', 'Q3', 'Q4');

-- Q3. Which sales channel brings in the most revenue?
SELECT 
	sales_channel,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY sales_channel
ORDER BY total_revenue_usd DESC;

-- Q4. Does offering a discount actually improve sales and customer satisfaction?
SELECT 
	discount_pct,
    COUNT(*)                        AS transactions,
    SUM(units_sold)                 AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)      AS total_revenue_usd,
    ROUND(AVG(revenue_usd), 2)      AS avg_order_value_usd,
    ROUND(AVG(customer_rating), 2)  AS avg_customer_rating
FROM apple_sales
GROUP BY discount_pct
ORDER BY discount_pct ASC;

-- Q5. Which months consistently perform best across all three years?
SELECT 
	year, 
    month,
    SUM(units_sold)             AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)  AS total_revenue_usd
FROM apple_sales
GROUP BY year, month
ORDER BY year, FIELD(month, 'January','February','March','April','May','June',
                           'July','August','September','October','November','December');


-- ----------------------------------------------------------------
-- Analysis 2: Product & Category
-- ----------------------------------------------------------------

-- Q6. Which product category generates the most revenue?
SELECT 
	category,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY category
ORDER BY total_revenue_usd DESC;

-- Q7. Which are the top 10 products by revenue?
SELECT 
	product_name, 
    category,
    COUNT(*)                        AS transactions,
    SUM(units_sold)                 AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)      AS total_revenue_usd,
    ROUND(AVG(revenue_usd), 2)      AS avg_order_value_usd
FROM apple_sales
GROUP BY product_name, category
ORDER BY total_revenue_usd DESC
LIMIT 10;

-- Q8. Which storage variant sells the most?
SELECT 
	storage,
    COUNT(*)                        AS transactions,
    SUM(units_sold)                 AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)      AS total_revenue_usd,
    ROUND(AVG(revenue_usd), 2)      AS avg_order_value_usd
FROM apple_sales
WHERE storage IS NOT NULL
GROUP BY storage
ORDER BY total_units_sold DESC;

-- Q9. Which color is most popular across all products?
SELECT 
	color,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY color
ORDER BY total_units_sold DESC;

-- Q10. What is the return rate by product category?
SELECT
  category,
  COUNT(*) 														AS transactions,
  SUM(CASE WHEN return_status = 'Returned'  THEN 1 ELSE 0 END)	AS total_returns,
  ROUND(SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END)
    * 100.0 / COUNT(*), 2) 										AS return_rate_pct
FROM apple_sales
GROUP BY category
ORDER BY return_rate_pct DESC;


-- ----------------------------------------------------------------
-- Analysis 3: Geographic
-- ----------------------------------------------------------------

-- Q11. Which region generates the most revenue?
SELECT region,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY region
ORDER BY total_revenue_usd DESC;

-- Q12. Which are the top 10 countries by revenue?
SELECT 
	country,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY country
ORDER BY total_revenue_usd DESC
LIMIT 10;

-- Q13. Which cities have the highest average order value?
SELECT 
	city,
    COUNT(*)                                                           AS transactions,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd
FROM apple_sales
GROUP BY city
ORDER BY avg_order_value_usd DESC
LIMIT 10;

-- Q14. What is the best-selling product category in each region?
WITH ranked_categories AS (
    SELECT region, category,
        SUM(units_sold) 												AS total_units_sold,
        RANK() OVER(PARTITION BY region ORDER BY SUM(units_sold) DESC)	AS rnk
    FROM apple_sales
    GROUP BY region, category
)
SELECT region, category, total_units_sold
FROM ranked_categories
WHERE rnk = 1
ORDER BY total_units_sold DESC;

-- Q15. Which countries have the highest return rates?
SELECT 
	country,
    COUNT(*)                        							AS transactions,
    SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
    ROUND(SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) 
    * 100.0 / COUNT(*), 2)              						AS return_rate_pct
FROM apple_sales
GROUP BY country
ORDER BY return_rate_pct DESC
LIMIT 10;


-- ----------------------------------------------------------------
-- Analysis 4: Customer Behaviour & Satisfaction
-- ----------------------------------------------------------------

-- Q16. Which customer segment generates the most revenue?
SELECT 
	customer_segment,
    COUNT(*)                                                           AS transactions,
    SUM(units_sold)                                                    AS total_units_sold,
    ROUND(SUM(revenue_usd), 2)                                         AS total_revenue_usd,
    ROUND(SUM(revenue_usd) * 100.0 / SUM(SUM(revenue_usd)) OVER(), 2)  AS revenue_share_pct,
    ROUND(AVG(revenue_usd), 2)                                         AS avg_order_value_usd
FROM apple_sales
GROUP BY customer_segment
ORDER BY total_revenue_usd DESC;

-- Q17. Which age group has the highest return rate?
SELECT 
	customer_age_group,
	COUNT(*)  													AS transactions,
    SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
    ROUND(SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) 
    * 100.0 / COUNT(*), 2) 										AS return_rate_pct
FROM apple_sales
GROUP BY customer_age_group
ORDER BY return_rate_pct DESC;

-- Q18. Which payment method is preferred by each age group?
WITH ranked_payment AS (
	SELECT customer_age_group, payment_method,
		COUNT(*) 																AS transactions,
		RANK() OVER (PARTITION BY customer_age_group ORDER BY COUNT(*) DESC)	AS rnk
	FROM apple_sales
	GROUP BY customer_age_group, payment_method
)
SELECT customer_age_group, payment_method, transactions
FROM ranked_payment
WHERE rnk = 1;

-- Q19. Where are Apple's customers coming from by previous device OS?
SELECT 
	previous_device_os,
    COUNT(*)                                                    AS total_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)           AS customer_share_pct,
    ROUND(SUM(revenue_usd), 2)                                  AS total_revenue_usd,
    ROUND(AVG(revenue_usd), 2)                                  AS avg_order_value_usd
FROM apple_sales
WHERE previous_device_os IS NOT NULL
GROUP BY previous_device_os
ORDER BY total_customers DESC;

-- Q20. Which product category is most preferred by each age group?
WITH ranked_categories AS (
    SELECT customer_age_group, category,
        SUM(units_sold) AS total_units_sold,
        RANK() OVER(PARTITION BY customer_age_group ORDER BY SUM(units_sold) DESC) AS rnk
    FROM apple_sales
    GROUP BY customer_age_group, category
)
SELECT customer_age_group, category, total_units_sold
FROM ranked_categories
WHERE rnk = 1
ORDER BY customer_age_group;


-- ----------------------------------------------------------------
-- Analysis 5: Advanced — Window Functions & CTEs
-- ----------------------------------------------------------------

-- Q21. What is the month-over-month revenue growth rate per year?
WITH monthly_revenue AS (
    SELECT year, month,
        DATE_FORMAT(sale_date, '%Y-%m')  AS month_start,
        ROUND(SUM(revenue_usd), 2)       AS monthly_revenue_usd
    FROM apple_sales
    GROUP BY year, month, DATE_FORMAT(sale_date, '%Y-%m')
),
mom_growth AS (
    SELECT year, month, monthly_revenue_usd,
        LAG(monthly_revenue_usd) OVER(PARTITION BY year ORDER BY month_start) AS prev_month_revenue_usd
    FROM monthly_revenue
)
SELECT year, month,
    monthly_revenue_usd,
    prev_month_revenue_usd,
    ROUND((monthly_revenue_usd - prev_month_revenue_usd) * 100.0
        / prev_month_revenue_usd, 2) AS mom_growth_pct
FROM mom_growth
ORDER BY year, FIELD(month, 'January','February','March','April','May','June',
                           'July','August','September','October','November','December');

-- Q22. What is the cumulative revenue by quarter per year?
WITH quarterly_revenue AS (
    SELECT year, quarter,
        ROUND(SUM(revenue_usd), 2) AS quarterly_revenue_usd
    FROM apple_sales
    GROUP BY year, quarter
)
SELECT year, quarter,
    quarterly_revenue_usd,
    ROUND(SUM(quarterly_revenue_usd) OVER(PARTITION BY year
	ORDER BY FIELD(quarter, 'Q1', 'Q2', 'Q3', 'Q4')), 2) AS cumulative_revenue_usd
FROM quarterly_revenue
ORDER BY year, FIELD(quarter, 'Q1', 'Q2', 'Q3', 'Q4');

-- Q23. Which products rank highest in revenue within their category?
WITH product_revenue AS (
    SELECT category, product_name,
        ROUND(SUM(revenue_usd), 2) AS total_revenue_usd
    FROM apple_sales
    GROUP BY category, product_name
)
SELECT category, product_name,
    total_revenue_usd,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY total_revenue_usd DESC) AS rnk
FROM product_revenue
ORDER BY category, rnk;

-- Q24. Who are the top 3 countries by revenue in each region?
WITH country_revenue AS (
    SELECT region, country,
        ROUND(SUM(revenue_usd), 2) AS total_revenue_usd
    FROM apple_sales
    GROUP BY region, country
),
ranked_countries AS (
    SELECT region, country, total_revenue_usd,
        DENSE_RANK() OVER(PARTITION BY region ORDER BY total_revenue_usd DESC) AS rnk
    FROM country_revenue
)
SELECT region, country, total_revenue_usd, rnk
FROM ranked_countries
WHERE rnk <= 3
ORDER BY region, rnk;

-- Q25. Which market tier does each country fall into based on revenue performance?
WITH country_revenue AS (
    SELECT region, country,
        ROUND(SUM(revenue_usd), 2) AS total_revenue_usd
    FROM apple_sales
    GROUP BY region, country
),
quartiles AS (
    SELECT region, country, total_revenue_usd,
        NTILE(4) OVER(ORDER BY total_revenue_usd DESC) AS quartile
    FROM country_revenue
)
SELECT region, country, total_revenue_usd, quartile,
    CASE WHEN quartile = 1 THEN 'Platinum'
         WHEN quartile = 2 THEN 'Gold'
         WHEN quartile = 3 THEN 'Silver'
         ELSE                   'Bronze'
    END AS market_tier
FROM quartiles
ORDER BY total_revenue_usd DESC;