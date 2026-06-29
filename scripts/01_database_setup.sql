-- ============================================================
-- APPLE GLOBAL PRODUCT SALES | SQL
-- 01 : Database Setup
-- ============================================================


-- Create and Select Database
CREATE DATABASE apple_sales_analysis;
USE apple_sales_analysis;


-- Create Table Structure
CREATE TABLE apple_sales (
    sale_id                 VARCHAR(20)     NOT NULL,
    sale_date               DATE            NOT NULL,
    year                    INT             NOT NULL,
    quarter                 VARCHAR(5)      NOT NULL,
    month                   VARCHAR(10)     NOT NULL,
    country                 VARCHAR(25)     NOT NULL,
    region                  VARCHAR(25)     NOT NULL,
    city                    VARCHAR(25)     NOT NULL,
    product_name            VARCHAR(35)     NOT NULL,
    category                VARCHAR(15)     NOT NULL,
    storage                 VARCHAR(15)     NULL,
    color                   VARCHAR(20)     NOT NULL,
    unit_price_usd          DECIMAL(10,2)   NOT NULL,
    discount_pct            DECIMAL(5,2)    NOT NULL,
    units_sold              INT             NOT NULL,
    discounted_price_usd    DECIMAL(10,2)   NOT NULL,
    revenue_usd             DECIMAL(12,2)   NOT NULL,
    currency                VARCHAR(10)     NOT NULL,
    fx_rate_to_usd          DECIMAL(10,4)   NOT NULL,
    revenue_local_currency  DECIMAL(15,2)   NOT NULL,
    sales_channel           VARCHAR(25)     NOT NULL,
    payment_method          VARCHAR(20)     NOT NULL,
    customer_segment        VARCHAR(15)     NOT NULL,
    customer_age_group      VARCHAR(10)     NOT NULL,
    previous_device_os      VARCHAR(10)     NULL,
    customer_rating         DECIMAL(3,1)    NULL,
    return_status           VARCHAR(10)     NOT NULL
);


-- Check Local Infile Setting Before Import
SHOW GLOBAL VARIABLES LIKE 'local_infile';


-- Load Data From CSV File
LOAD DATA LOCAL INFILE 'C:/Users/dell/Desktop/apple-sales-analysis-sql/data/apple_global_sales_dataset.csv'
INTO TABLE apple_sales
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Verify Data Was Loaded Correctly
SELECT * 
FROM apple_sales
LIMIT 10;