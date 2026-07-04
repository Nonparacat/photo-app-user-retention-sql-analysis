-- 05_payment_analysis.sql
-- Payment conversion, revenue, ARPPU, and repeat purchase rate.

WITH paid_orders AS (
    SELECT * FROM orders WHERE payment_status = 'paid'
),
pay_user AS (
    SELECT user_id, COUNT(DISTINCT order_id) AS order_count, SUM(amount) AS user_revenue
    FROM paid_orders
    GROUP BY user_id
)
SELECT
    COUNT(DISTINCT u.user_id) AS registered_users,
    COUNT(DISTINCT p.user_id) AS paid_users,
    ROUND(1.0 * COUNT(DISTINCT p.user_id) / COUNT(DISTINCT u.user_id), 4) AS payment_conversion_rate,
    ROUND(SUM(COALESCE(p.user_revenue, 0)), 2) AS total_revenue,
    ROUND(SUM(COALESCE(p.user_revenue, 0)) / NULLIF(COUNT(DISTINCT p.user_id), 0), 2) AS arppu,
    COUNT(DISTINCT CASE WHEN p.order_count >= 2 THEN p.user_id END) AS repeat_paid_users,
    ROUND(1.0 * COUNT(DISTINCT CASE WHEN p.order_count >= 2 THEN p.user_id END) / NULLIF(COUNT(DISTINCT p.user_id), 0), 4) AS repeat_purchase_rate
FROM users u
LEFT JOIN pay_user p ON u.user_id = p.user_id;
