SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(p.amount) / 100.0 AS total_deposits
FROM
    users_customuser u
JOIN
    plans_plan p ON u.id = p.owner_id
WHERE
    (p.is_regular_savings = 1 OR p.is_a_fund = 1)  -- I only incuded the two  relevant columns
GROUP BY
    u.id, u.first_name, u.last_name
HAVING
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) >= 1
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) >= 1
ORDER BY
    total_deposits DESC;