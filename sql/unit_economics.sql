
-- UNIT ECONOMICS BY COUNTRY
-- Metrics: CAC, ARPU, LTV, LTV–CAC, ROAS, Conversion Rate
-- Source views: v_events_clean, v_marketing_clean


WITH product_metrics AS (

    SELECT
        country,
        COUNT(DISTINCT user_id)  AS total_users,
        SUM(revenue) AS total_revenue,
        COUNT(DISTINCT CASE WHEN event_type = 'subscription' THEN user_id END) AS paid_users
    FROM v_events_clean
    GROUP BY country

),

marketing_metrics AS (

    SELECT
        country,
        SUM(cost) AS total_spend
    FROM v_marketing_clean
    GROUP BY country

),

churn_metrics AS (

    SELECT
        country,
        COUNT(DISTINCT CASE WHEN event_type = 'cancel'       THEN user_id END) AS churned_users,
        COUNT(DISTINCT CASE WHEN event_type = 'subscription' THEN user_id END) AS subscribed_users
    FROM v_events_clean
    GROUP BY country

)

SELECT
    p.country,
    p.total_users,

    -- Cost to acquire one user
    ROUND(m.total_spend / NULLIF(p.total_users, 0), 2)  AS cac,

    -- Average revenue per user
    ROUND(p.total_revenue / NULLIF(p.total_users, 0), 2) AS arpu,

    -- Churn rate: share of subscribers who cancelled
    ROUND(
        c.churned_users::NUMERIC
        / NULLIF(c.subscribed_users, 0) * 100,
    2)   AS churn_rate_pct,

    -- LTV = ARPU / Churn Rate: expected total revenue per user
    ROUND(
        (p.total_revenue / NULLIF(p.total_users, 0))
        / NULLIF(c.churned_users::NUMERIC / NULLIF(c.subscribed_users, 0), 0),
    2)  AS ltv,

    -- LTV – CAC: net margin per user (> 0 means profitable)
    ROUND(
        (p.total_revenue / NULLIF(p.total_users, 0))
        / NULLIF(c.churned_users::NUMERIC / NULLIF(c.subscribed_users, 0), 0)
        - (m.total_spend / NULLIF(p.total_users, 0)),
    2) AS ltv_minus_cac,

    -- ROAS: revenue returned per $1 spent (1.0 = break-even)
    ROUND(
        p.total_revenue / NULLIF(m.total_spend, 0),
    2) AS roas,

    -- Share of users who converted to paid subscription
    ROUND(p.paid_users::NUMERIC / NULLIF(p.total_users, 0) * 100, 2)           AS conversion_rate_pct

FROM product_metrics    p
JOIN marketing_metrics  m ON p.country = m.country
JOIN churn_metrics      c ON p.country = c.country

ORDER BY ltv_minus_cac DESC;
