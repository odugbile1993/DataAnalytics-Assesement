/*
Transaction Frequency Analysis
Categorizes customers based on their average monthly transaction frequency:
- High Frequency: ≥10 transactions/month
- Medium Frequency: 3-9 transactions/month
- Low Frequency: ≤2 transactions/month
*/
WITH customer_monthly_stats AS (
    SELECT
        s.owner_id,
        -- Count distinct months with transactions
        COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m-01')) AS active_months,
        -- Calculate average monthly transactions (handling divide-by-zero)
        COUNT(*) / NULLIF(COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m-01')), 0) AS avg_monthly_transactions
    FROM
        savings_savingsaccount s
    GROUP BY
        s.owner_id
)

SELECT
    CASE
        WHEN avg_monthly_transactions >= 10 THEN 'High Frequency'
        WHEN avg_monthly_transactions >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_monthly_transactions), 1) AS avg_transactions_per_month
FROM
    customer_monthly_stats
GROUP BY
    frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;