SQL Assessment Solutions

Hi there! This document explains my approach to solving the four SQL problems for the data analyst assessment. I'll walk through each solution, share the challenges I faced, and how I worked through them.

The Solutions

Dataset Preparation:

Downloaded the provided database file

Imported it into MySQL Workbench on my local machine

Verified all tables (users_customuser, savings_savingsaccount, plans_plan, withdrawals_withdrawal) were correctly loaded

Development Process:

Explored the data directly in MySQL Workbench using:

sql

DESCRIBE table_name;

SELECT * FROM table_name LIMIT 5;

Developed and tested queries in MySQL Workbench's query editor

Once finalized, copied only the working SQL code (no database connections or setup commands) into VS Code

Saved each solution as separate .sql files (Q1-Q4) following the required naming convention

1. Finding High-Value Customers
   
What I Needed to Do:
Identify customers who have both savings and investment accounts, sorted by their total deposits.

How I Solved It:

Joined the customer, plans, and savings tables

Used CASE WHEN statements to count savings vs investment accounts separately

Made sure to convert amounts from kobo to dollars (dividing by 100)

Added checks to ensure customers had both account types

Tricky Part:
At first I looked for account flags in the savings table, but they were actually in the plans table. I caught this by checking the table structures first.

2. Analyzing Transaction Frequency
   
The Goal:
Categorize customers as High/Medium/Low frequency based on monthly transactions.

My Approach:

Calculated how many months each customer was active

Divided total transactions by active months to get monthly average

Created three buckets using CASE WHEN:

High: 10+ transactions/month

Medium: 3-9

Low: 0-2

Helpful Tip:
I tested the date formatting separately to make sure monthly grouping worked right.

3. Flagging Inactive Accounts
4. 
The Task:
Find accounts with no transactions in over a year.

How I Built It:

Calculated days since last transaction with DATEDIFF

Made sure to only include active customers

Added a severity classification (showing accounts inactive 1-2 years vs 2+ years)

Used LEFT JOIN to catch accounts with no transactions at all

Challenge:

I initially looked for an is_active flag in the wrong table. Double-checking the schema fixed this.

4. Calculating Customer Lifetime Value
The Objective:
Estimate how valuable each customer is based on their transaction history.

The Formula:

(Total Transactions ÷ Months as Customer) × 12 × (0.1% of Their Total Deposits)
Key Points:

Handled new customers (avoiding divide-by-zero errors)

Properly converted kobo amounts

Made the profit calculation clear with comments

Tested the math with sample customers

Validation:
I spot-checked several customers with hand calculations to verify the results.

Challenges & Learnings
Schema Surprises
I learned to always check table structures first - assumptions about column names can be wrong!

Date Calculations
Date functions vary by SQL dialect. I stuck with MySQL's DATE_FORMAT and DATEDIFF for consistency.

Edge Cases Matter
Nearly missed handling new customers in the CLV calculation. Adding NULLIF saved the day.

Verification is Key
For each query, I wrote simple test queries to verify parts of the calculation.
