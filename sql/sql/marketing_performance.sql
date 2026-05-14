
-- MARKETING PERFORMANCE BY CHANNEL & COUNTRY
-- Metrics: CTR, CPC, Total Spend
-- Source view: v_marketing_clean

SELECT
    country,
    channel,

    -- Click-through rate: measures creative engagement
    ROUND(SUM(clicks)::NUMERIC / NULLIF(SUM(impressions), 0) * 100, 2) AS ctr_pct,

    -- Cost per click: measures acquisition efficiency
    ROUND(SUM(cost) / NULLIF(SUM(clicks), 0), 2)AS cpc,

    -- Total channel spend for budget allocation analysis
    ROUND(SUM(cost), 2) AS total_spend

FROM v_marketing_clean

GROUP BY country, channel
ORDER BY country, cpc ASC;
