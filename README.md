# Customer Performance & Revenue Analysis

## Overview

This project analyzes customer purchasing behavior using
PostgreSQL and a relational sales database.

The analysis focuses on customer revenue, purchasing
frequency, product diversity, high-value orders, and
regional performance.

## Analytical Approach

The query is structured using multiple Common Table Expressions (CTEs), with each stage operating at a deliberate grain.

### 1. Order-level metrics
**Grain:** one row per order

The first CTE calculates:
Units purchased
Order revenue
Revenue is calculated from:
quantity × unit price
Establishing the order-level grain first helps prevent double-counting when order details are joined to customer information.

### 2. Customer product diversity
**Grain:** one row per customer

The second CTE calculates the number of distinct products purchased by each customer.

### 3. Customer performance metrics
**Grain:** one row per customer

- The third CTE combines customer, order, and order-level metrics to calculate:
- Order count
- Total units purchased
- Total revenue
- Average order value
- High-value order count
- Percentage of high-value orders
- Number of different products purchased

A LEFT JOIN from the customer table ensures customers without orders are retained in the analysis.

### 4. Regional analysis
The final query uses window functions to calculate:

- Regional average customer revenue
- Difference from the regional average
- Customer contribution to regional revenue
- Regional revenue quartile

Customers are also classified into three revenue-based segments:
- `no_revenue`
- `regular`
- `high_value`

## Business Questions

- How many orders does each customer place?
- How much revenue does each customer generate?
- What is the average order value?
- How many different products does each customer purchase?
- How many high-value orders does each customer place?
- What percentage of their orders are high-value?
- How does each customer's revenue compare with the
  regional average?
- What percentage of regional revenue does each customer
  contribute?
- Which revenue quartile does each customer belong to?

## Database Structure

customers --> orders --> order_details --> products --> categories

## SQL Techniques

- `Common Table Expressions (CTEs)`
- `LEFT JOIN`
- `GROUP BY`
- `Conditional aggregation`
- `Filter clause`
- `Window functions`
- `NTILE`
- `NULLIF`
- `CASE statements`
- `COUNT(DISTINCT ...)`
- `COALESCE`
- `NULLIF`
- `CASE`

## Key Analytical Concepts

The analysis carefully controls the grain of each
intermediate dataset to avoid double-counting revenue
when joining order-level and order-detail-level data.

## Output

The final dataset contains one row per customer and
includes:

- Order count
- Total units purchased
- Unique products purchased
- Total revenue
- Average order value
- High-value order count
- High-value order percentage
- Regional average revenue
- Difference from regional average
- Regional revenue contribution
- Revenue quartile
- Customer status

## Example Outputs<img width="1920" height="1200" alt="example_output2" src="https://github.com/user-attachments/assets/f5238847-128a-49fd-918a-cd49ad8ad22b" />
<img width="1920" height="1200" alt="example_output1" src="https://github.com/user-attachments/assets/c6eda271-5184-477c-b1b2-9da823a4b059" />
<img width="1920" height="1200" alt="example_output4" src="https://github.com/user-attachments/assets/f6a72dbb-643a-4d4f-936c-d26a98787491" />
<img width="1920" height="1200" alt="example_output3" src="https://github.com/user-attachments/assets/77388cb1-d131-4777-8a02-88267645543f" />

## Schema
<img width="561" height="894" alt="schema" src="https://github.com/user-attachments/assets/0469c045-2d37-4f5d-8ba5-9ad80185aff1" />

## Tools

- PostgreSQL
- pgAdmin
- SQL

## Author

Shass
