-- 06_channel_analysis.sql
-- Channel comparison: activation, retention, payment conversion, and revenue.

WITH active_user AS (
    SELECT DISTINCT user_id FROM events WHERE event_name = 'app_open'
),
paid_user AS (
    SELECT user_id, SUM(amount) AS revenue
    FROM orders
    WHERE payment_status = 'paid'
    GROUP BY user_id
),
d1_retained AS (
    SELECT DISTINCT u.user_id
    FROM users u
    JOIN events e ON u.user_id = e.user_id
        AND e.event_name = 'app_open'
        AND CAST(julianday(e.event_date) - julianday(u.register_date) AS INTEGER) = 1
),
d7_retained AS (
    SELECT DISTINCT u.user_id
    FROM users u
    JOIN events e ON u.user_id = e.user_id
        AND e.event_name = 'app_open'
        AND CAST(julianday(e.event_date) - julianday(u.register_date) AS INTEGER) = 7
)
SELECT
    u.channel,
    COUNT(DISTINCT u.user_id) AS registered_users,
    COUNT(DISTINCT a.user_id) AS active_users,
    ROUND(1.0 * COUNT(DISTINCT a.user_id) / COUNT(DISTINCT u.user_id), 4) AS activation_rate,
    ROUND(1.0 * COUNT(DISTINCT d1.user_id) / COUNT(DISTINCT u.user_id), 4) AS d1_retention_rate,
    ROUND(1.0 * COUNT(DISTINCT d7.user_id) / COUNT(DISTINCT u.user_id), 4) AS d7_retention_rate,
    COUNT(DISTINCT p.user_id) AS paid_users,
    ROUND(1.0 * COUNT(DISTINCT p.user_id) / COUNT(DISTINCT u.user_id), 4) AS payment_conversion_rate,
    ROUND(SUM(COALESCE(p.revenue, 0)), 2) AS revenue,
    ROUND(SUM(COALESCE(p.revenue, 0)) / NULLIF(COUNT(DISTINCT p.user_id), 0), 2) AS arppu
FROM users u
LEFT JOIN active_user a ON u.user_id = a.user_id
LEFT JOIN paid_user p ON u.user_id = p.user_id
LEFT JOIN d1_retained d1 ON u.user_id = d1.user_id
LEFT JOIN d7_retained d7 ON u.user_id = d7.user_id
GROUP BY u.channel
ORDER BY payment_conversion_rate DESC;
