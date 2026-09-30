**Customer Performance & Revenue Analysis**

**Overview**
This project analyzes customer purchasing behavior using PostgreSQL and a relational sales database.
The analysis evaluates customer purchasing activity, revenue generation, high-value orders, product diversity, and performance relative to other customers within the same region. The final analytical dataset has a one-row-per-customer grain.

**Business Questions**
This analysis answers questions such as:

How many orders has each customer placed?
How many units has each customer purchased?
How many different products has each customer purchased?
How much total revenue has each customer generated?
What is the customer's average order value?
How many high-value orders (over 500) has each customer placed?
What percentage of the customer's orders are high-value?
How does each customer's revenue compare with the regional average?
What percentage of regional revenue does each customer contribute?
Which regional revenue quartile does each customer belong to?
How can customers be segmented according to revenue?

**Database Structure**
The analysis uses a relational database containing customer, order, order-detail, product, and category information.

customers
    |
    | CustomerID
    v
orders
    |
    | OrderID
    v
order_details
    |
    | ProductID
    v
products
    |
    | CategoryID
    v
categories

The main analysis uses the following relationships:
customers → orders through CustomerID
orders → order_details through OrderID
order_details → products through ProductID
Analytical Approach

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
no_revenue
regular
high_value

SQL Techniques Demonstrated:
Common Table Expressions (CTEs)
INNER JOIN
LEFT JOIN
GROUP BY
Conditional aggregation
COUNT(DISTINCT ...)
FILTER
Window functions
AVG() OVER()
SUM() OVER()
NTILE()
CASE
NULLIF
Data-grain management
Revenue segmentation

Key Analytical Concept: Data Grain
A major focus of this project is controlling the grain of intermediate datasets.
The analysis deliberately moves through:

Order Details
      ↓
One row per order
      ↓
One row per customer
      ↓
Regional customer analysis

This prevents order-level metrics from being accidentally duplicated when working with the one-to-many relationship between orders and order details.

Example Output




Database Schema




Tools
PostgreSQL
pgAdmin
SQL
Project Files
customer-performance-analysis/
│
├── README.md
│
├── sql/
│   └── customer_performance_analysis.sql
│
└── screenshots/
    ├── customer_analysis.png
    └── database_schema.png
    
Author
Shass

