-- 07_feature_payment_comparison.sql
-- Compare payment conversion between users who used key features and users who did not.

WITH user_feature AS (
    SELECT
        u.user_id,
        MAX(CASE WHEN e.event_name = 'filter_use' THEN 1 ELSE 0 END) AS used_filter,
        MAX(CASE WHEN e.event_name = 'photo_export' THEN 1 ELSE 0 END) AS used_export
    FROM users u
    LEFT JOIN events e ON u.user_id = e.user_id
    GROUP BY u.user_id
),
paid_user AS (
    SELECT DISTINCT user_id FROM orders WHERE payment_status = 'paid'
)
SELECT
    used_filter,
    used_export,
    COUNT(DISTINCT uf.user_id) AS users,
    COUNT(DISTINCT p.user_id) AS paid_users,
    ROUND(1.0 * COUNT(DISTINCT p.user_id) / COUNT(DISTINCT uf.user_id), 4) AS payment_conversion_rate
FROM user_feature uf
LEFT JOIN paid_user p ON uf.user_id = p.user_id
GROUP BY used_filter, used_export
ORDER BY used_filter DESC, used_export DESC;
