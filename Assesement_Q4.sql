/*
Customer Lifetime Value (CLV) Estimation
Calculates CLV based on:
- Account tenure (months since signup)
- Transaction count
- 0.1% profit per transaction value
*/
SELECT
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    -- Calculate complete months since account creation
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    -- Count all transactions (both deposits and withdrawals)
    COUNT(s.id) AS total_transactions,
    /*
    CLV Calculation Formula:
    (total_transactions / tenure_months) * 12 → annualized transactions
    Multiplied by average profit per transaction (0.1% of transaction value)
    Note: confirmed_amount is in kobo, so we divide by 100 for currency conversion
    */
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0) * 12 * 
        (SUM(s.confirmed_amount) / 100 * 0.001)
    ), 2) AS estimated_clv
FROM
    users_customuser u
JOIN
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY
    u.id, u.first_name, u.last_name, u.date_joined
HAVING
    -- Exclude customers who joined this month (tenure = 0)
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) > 0
ORDER BY
    estimated_clv DESC;
