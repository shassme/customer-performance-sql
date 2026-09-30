# Customer Performance & Revenue Analysis

## Overview

This project analyzes customer purchasing behavior using
PostgreSQL and a relational sales database.

The analysis focuses on customer revenue, purchasing
frequency, product diversity, high-value orders, and
regional performance.

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

customers
    |
    v
orders
    |
    v
order_details
    |
    v
products
    |
    v
categories

## SQL Techniques

- Common Table Expressions (CTEs)
- INNER JOIN
- LEFT JOIN
- GROUP BY
- Conditional aggregation
- Window functions
- NTILE
- NULLIF
- COALESCE
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

Sherif
