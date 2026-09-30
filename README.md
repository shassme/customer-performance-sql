# Customer Performance & Revenue Analysis

## Overview

This project analyzes customer purchasing behavior using
PostgreSQL and a relational sales database.

The analysis focuses on customer revenue, purchasing
frequency, product diversity, high-value orders, and
regional performance.

## Analytical Approach

The query is structured using multiple Common Table Expressions (CTEs), with each stage operating at a deliberate grain.

1. Order-level metrics
Grain: one row per order

The first CTE calculates:
Units purchased
Order revenue
Revenue is calculated from:
quantity × unit price
Establishing the order-level grain first helps prevent double-counting when order details are joined to customer information.

2. Customer product diversity
Grain: one row per customer

The second CTE calculates the number of distinct products purchased by each customer.

3. Customer performance metrics
Grain: one row per customer

The third CTE combines customer, order, and order-level metrics to calculate:
Order count
Total units purchased
Total revenue
Average order value
High-value order count
Percentage of high-value orders
Number of different products purchased

A LEFT JOIN from the customer table ensures customers without orders are retained in the analysis.

4. Regional analysis
The final query uses window functions to calculate:

Regional average customer revenue
Difference from the regional average
Customer contribution to regional revenue
Regional revenue quartile

Customers are also classified into three revenue-based segments:
-no_revenue
-regular
-high_value

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

- Common Table Expressions (CTEs)
- LEFT JOIN
- GROUP BY
- Conditional aggregation
- Filter
- Window functions
- NTILE
- NULLIF
- CASE statements

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

## Tools

- PostgreSQL
- pgAdmin
- SQL

## Author

Shass
