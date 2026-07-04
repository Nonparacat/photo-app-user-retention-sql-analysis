-- 02_dau_new_users.sql
-- DAU, new users, and active new user ratio.

WITH dau AS (
    SELECT event_date AS dt, COUNT(DISTINCT user_id) AS dau
    FROM events
    WHERE event_name = 'app_open'
    GROUP BY event_date
),
new_users AS (
    SELECT register_date AS dt, COUNT(DISTINCT user_id) AS new_users
    FROM users
    GROUP BY register_date
)
SELECT
    dau.dt,
    dau.dau,
    COALESCE(new_users.new_users, 0) AS new_users,
    ROUND(1.0 * COALESCE(new_users.new_users, 0) / NULLIF(dau.dau, 0), 4) AS active_new_user_ratio
FROM dau
LEFT JOIN new_users ON dau.dt = new_users.dt
ORDER BY dau.dt;
