-- 03_retention_analysis.sql
-- D1 and D7 retention by registration cohort and channel.

WITH first_open AS (
    SELECT DISTINCT user_id, event_date
    FROM events
    WHERE event_name = 'app_open'
),
cohort_activity AS (
    SELECT
        u.user_id,
        u.register_date,
        u.channel,
        f.event_date,
        CAST(julianday(f.event_date) - julianday(u.register_date) AS INTEGER) AS day_diff
    FROM users u
    LEFT JOIN first_open f ON u.user_id = f.user_id
)
SELECT
    register_date,
    channel,
    COUNT(DISTINCT user_id) AS cohort_users,
    COUNT(DISTINCT CASE WHEN day_diff = 1 THEN user_id END) AS d1_retained_users,
    ROUND(1.0 * COUNT(DISTINCT CASE WHEN day_diff = 1 THEN user_id END) / COUNT(DISTINCT user_id), 4) AS d1_retention_rate,
    COUNT(DISTINCT CASE WHEN day_diff = 7 THEN user_id END) AS d7_retained_users,
    ROUND(1.0 * COUNT(DISTINCT CASE WHEN day_diff = 7 THEN user_id END) / COUNT(DISTINCT user_id), 4) AS d7_retention_rate
FROM cohort_activity
GROUP BY register_date, channel
ORDER BY register_date, channel;
