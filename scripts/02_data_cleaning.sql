-- ============================================================
-- 02 : Data Cleaning
-- ============================================================


-- Check Total Row Count
SELECT COUNT(*) AS total_rows
FROM apple_sales;

-- Replace 'N/A' and 0.0 Values With NULL
UPDATE apple_sales SET storage            = NULL WHERE storage            = 'N/A';
UPDATE apple_sales SET previous_device_os = NULL WHERE previous_device_os = 'N/A';
UPDATE apple_sales SET customer_rating    = NULL WHERE customer_rating    =  0.0 ;

-- Validate NULL Counts After Cleaning
SELECT
    COUNT(*)                                                        AS total_rows,
    SUM(CASE WHEN storage            IS NULL THEN 1 ELSE 0 END)    AS null_storage,
    SUM(CASE WHEN previous_device_os IS NULL THEN 1 ELSE 0 END)    AS null_prev_os,
    SUM(CASE WHEN customer_rating    IS NULL THEN 1 ELSE 0 END)    AS null_rating
FROM apple_sales;

-- Check for Duplicate Transactions
SELECT sale_id, COUNT(*) AS duplicate_count
FROM apple_sales
GROUP BY sale_id
HAVING COUNT(*) > 1;

-- Check for hidden characters in return_status
SELECT DISTINCT return_status, HEX(return_status)
FROM apple_sales;

-- Remove carriage return characters (\r) from return_status
UPDATE apple_sales
SET return_status = REPLACE(return_status, '\r', '');

-- VALIDATE DATE RANGE
SELECT
    MIN(sale_date) AS first_sale_date,
    MAX(sale_date) AS last_sale_date
FROM apple_sales;




