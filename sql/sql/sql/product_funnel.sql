-- PRODUCT FUNNEL BY COUNTRY
-- Metrics: Engagement Rate, Churn Rate
-- Source view: v_events_clean

SELECT
    country,

    -- Total unique users in the period
    COUNT(DISTINCT user_id) AS total_users,

    -- Users who logged at least one workout
    COUNT(DISTINCT CASE WHEN event_type = 'workout'THEN user_id END) AS active_trainers,

    -- Share of users who trained at least once
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'workout'  THEN user_id END)::NUMERIC
        / NULLIF(COUNT(DISTINCT user_id), 0) * 100,
    2) AS engagement_rate_pct,

    -- Users who cancelled their subscription
    COUNT(DISTINCT CASE WHEN event_type = 'cancel'THEN user_id END)AS churned_users,

    -- Churn rate: cancellations / subscriptions
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'cancel'THEN user_id END)::NUMERIC
        / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'subscription' THEN user_id END), 0) * 100,
    2) AS churn_rate_pct

FROM v_events_clean

GROUP BY country
ORDER BY churn_rate_pct ASC;
