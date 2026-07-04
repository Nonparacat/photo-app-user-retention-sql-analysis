-- 04_funnel_analysis.sql
-- User conversion funnel from registration to payment.

WITH funnel AS (
    SELECT '01_registered' AS step, COUNT(DISTINCT user_id) AS users FROM users
    UNION ALL SELECT '02_app_open', COUNT(DISTINCT user_id) FROM events WHERE event_name = 'app_open'
    UNION ALL SELECT '03_photo_upload', COUNT(DISTINCT user_id) FROM events WHERE event_name = 'photo_upload'
    UNION ALL SELECT '04_filter_use', COUNT(DISTINCT user_id) FROM events WHERE event_name = 'filter_use'
    UNION ALL SELECT '05_photo_export', COUNT(DISTINCT user_id) FROM events WHERE event_name = 'photo_export'
    UNION ALL SELECT '06_subscription_click', COUNT(DISTINCT user_id) FROM events WHERE event_name = 'subscription_click'
    UNION ALL SELECT '07_paid', COUNT(DISTINCT user_id) FROM orders WHERE payment_status = 'paid'
)
SELECT
    step,
    users,
    ROUND(1.0 * users / FIRST_VALUE(users) OVER (ORDER BY step), 4) AS conversion_from_registered,
    ROUND(1.0 * users / NULLIF(LAG(users) OVER (ORDER BY step), 0), 4) AS conversion_from_previous
FROM funnel
ORDER BY step;
