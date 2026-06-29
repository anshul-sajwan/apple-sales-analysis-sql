# Apple Global Product Sales | SQL 

A MySQL project analyzing Apple’s global product sales data across 47 countries, 6 product categories, and 3 years (2022–2024). The project answers 25 business questions across 5 analysis sections.

---

## 📁 Dataset

| Attribute | Details |
|-----------|---------|
| Source | [Kaggle — Apple Global Product Sales Dataset](https://www.kaggle.com/datasets/ashyou09/apple-global-product-sales-dataset) |
| Rows | 11,500 transactions |
| Columns | 27 |
| Period | January 2022 – December 2024 |
| Geographic Scope | 47 countries across 8 regions |
| Product Scope | 43 products across 6 categories |

---

## 🛠️ SQL Concepts Used

| Concept | Used in |
|---------|---------|
| CREATE DATABASE, CREATE TABLE | Schema Design |
| LOAD DATA LOCAL INFILE | Data Import |
| UPDATE, NULL Handling, HEX | Data Cleaning |
| GROUP BY, HAVING, ORDER BY | Aggregations |
| SUM(), COUNT(), AVG(), ROUND() | Aggregate Functions |
| CASE WHEN | Conditional Aggregation |
| WITH (CTEs) | Multi-step Logic |
| LAG(), RANK(), DENSE_RANK(), NTILE() | Window Functions |
| PARTITION BY | Window Partitioning |

---

## 🗂️ Schema

**Table:** `apple_sales` | **Rows:** 11,500 | **Columns:** 27

| Column | Type | Description |
|---|---|---|
| sale_id | VARCHAR(20) | Unique transaction ID |
| sale_date | DATE | Transaction date |
| year | INT | Sale year (2022–2024) |
| quarter | VARCHAR(5) | Quarter (Q1–Q4) |
| month | VARCHAR(10) | Month name (January–December) |
| country | VARCHAR(25) | Country of sale |
| region | VARCHAR(25) | Geographic region |
| city | VARCHAR(25) | City of sale |
| product_name | VARCHAR(35) | Product name |
| category | VARCHAR(15) | iPhone, iPad, Mac, Apple Watch, AirPods, Accessories |
| storage | VARCHAR(15) | Storage variant: NULL for products without storage |
| color | VARCHAR(20) | Color of the product |
| unit_price_usd | DECIMAL(10,2) | Original price per unit in USD |
| discount_pct | DECIMAL(5,2) | Discount applied: 0, 2, 3, 5, 7, 10, or 15% |
| units_sold | INT | Number of units in the transaction |
| discounted_price_usd | DECIMAL(10,2) | Price per unit after discount |
| revenue_usd | DECIMAL(12,2) | Transaction revenue in USD |
| currency | VARCHAR(10) | Local currency code |
| fx_rate_to_usd | DECIMAL(10,4) | Exchange rate used for local currency conversion |
| revenue_local_currency | DECIMAL(15,2) | Revenue in local currency |
| sales_channel | VARCHAR(25) | Apple Store, Online, Authorized Reseller, Carrier Store, Third-Party Retailer, Corporate/B2B |
| payment_method | VARCHAR(20) | Credit Card, Debit Card, Apple Pay, EMI, Net Banking, Cash, Gift Card |
| customer_segment | VARCHAR(15) | Individual, Business, Student, Government |
| customer_age_group | VARCHAR(10) | 18–24, 25–34, 35–44, 45–54, 55+ |
| previous_device_os | VARCHAR(10) | Previous device OS: NULL for non-iPhone buyers |
| customer_rating | DECIMAL(3,1) | Post-purchase rating 3.0–5.0 (around 30% are NULL) |
| return_status | VARCHAR(10) | Kept, Returned, or Exchanged |

---

## 📊 Business Questions Answered

**Sales Performance (Q1–Q5)**
- Q1. What is the overall sales performance of the business?
- Q2. What are the quarterly trends in revenue and units sold from 2022 to 2024?
- Q3. Which sales channel brings in the most revenue?
- Q4. Does offering a discount actually improve sales and customer satisfaction?
- Q5. Which months consistently perform best across all three years?

**Product & Category (Q6–Q10)**
- Q6. Which product category generates the most revenue?
- Q7. Which are the top 10 products by revenue?
- Q8. Which storage variant sells the most?
- Q9. Which color is most popular across all products?
- Q10. What is the return rate by product category?

**Geographic Analysis (Q11–Q15)**
- Q11. Which region generates the most revenue?
- Q12. Which are the top 10 countries by revenue?
- Q13. Which cities have the highest average order value?
- Q14. What is the best-selling product category in each region?
- Q15. Which countries have the highest return rates?

**Customer Behaviour & Satisfaction (Q16–Q20)**
- Q16. Which customer segment generates the most revenue?
- Q17. Which age group has the highest return rate?
- Q18. Which payment method is preferred by each age group?
- Q19. Where are Apple's customers coming from by previous device OS?
- Q20. Which product category is most preferred by each age group?

**Advanced — Window Functions & CTEs (Q21–Q25)**
- Q21. What is the month-over-month revenue growth rate per year?
- Q22. What is the cumulative revenue by quarter per year?
- Q23. Which products rank highest in revenue within their category?
- Q24. Who are the top 3 countries by revenue in each region?
- Q25. Which market tier does each country fall into based on revenue performance?

---

## 🔍 Key Findings

- Mac contributed 46.41% of total revenue despite being third in transaction
  volume. Mac Pro (M2 Ultra) alone had an avg order value of $13,542.

- Around 45% of transactions were completed at full price with no discount.
  The 15% discount tier recorded the lowest avg order value ($1,201) while
  customer ratings stayed nearly the same across all discount levels.

- iPhone was the top selling category across all 8 regions.
  The United States ranked last among 47 countries in total revenue despite
  being Apple's home market.

- 2023 was the weakest year with revenue falling to $5.78M. August 2023
  recorded the sharpest monthly decline (-38.55%), followed by a strong
  recovery in September (+50.67%). Revenue bounced back in 2024, reaching the
  highest yearly total at $6.21M.

---

## 💡 Recommendations

- Hong Kong, Japan and Malaysia are the top 3 Asian markets by revenue and all ranked
  in the Platinum tier. Increasing Mac-focused marketing in these markets could drive 
  stronger returns as Mac is already the highest revenue category.

- Discounts above 10% reduced avg order value without improving customer
  ratings. Financing options or trade-in programs would be a better
  alternative than deeper price cuts.

- The United States ranking last among 47 countries needs further investigation.
  It could be a data limitation, sales channel difference, or actual
  market underperformance.

- Denmark, Kenya, Australia and Nigeria recorded the highest return rates, each above
  10%. These markets need closer attention at the product or customer
  expectation level.

---

## 🚀 How to Run This Project

1. Download the dataset.

2. Run the SQL scripts in order:
   - `sql/01_database_setup.sql`
   - `sql/02_data_cleaning.sql`
   - `sql/03_business_analysis.sql`

---

## 🤝 Connect With Me

- **LinkedIn:** [linkedin.com/in/anshul-sajwan](https://www.linkedin.com/in/anshul-sajwan)
- **GitHub:** [github.com/anshul-sajwan](https://github.com/anshul-sajwan)
