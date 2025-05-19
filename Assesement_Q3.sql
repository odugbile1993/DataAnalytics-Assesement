SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Savings'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days
FROM
    plans_plan p
LEFT JOIN
    savings_savingsaccount s ON p.id = s.plan_id
INNER JOIN
    users_customuser u ON p.owner_id = u.id AND u.is_active = 1
GROUP BY
    p.id, p.owner_id, p.is_a_fund
HAVING
    MAX(s.transaction_date) IS NULL
    OR MAX(s.transaction_date) < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY)
ORDER BY
    inactivity_days DESC;