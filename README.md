# Fitness App Analytics: Unit Economics & Product Funnel Audit

**[View the Tableau Dashboard →](https://public.tableau.com/views/Fitnessapp_17793454772490/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**


## Overview

A global fitness app was spending more on user acquisition than it earned back. I cleaned the data, calculated the unit economics, and identified where the model broke down.

The data came from two separate systems — AppsFlyer and internal transaction records.

---

## What I Built

An analytics pipeline in PostgreSQL that standardizes and joins the two data sources into SQL views, ready for Tableau.

**Technical decisions:**
- Used CTEs throughout to keep the SQL modular and readable
- Deduplicated transaction records to fix inflated revenue numbers
- Standardized country names and device types across both sources
- Joined marketing spend with user behavior to calculate CPC, CTR, and ROAS by country and channel

---

## Key Findings

### 1. Every market runs at a loss

ROAS is shown as a multiplier: 1.0x means break-even; below that, the market loses money.

| Market | Total Spend | Total Revenue | ROAS | CAC | ARPU |
|--------|------------|--------------|------|-----|------|
| Brazil | $3,704 | $2,978 | 0.80x | $6.00 | $4.83 |
| Spain | $3,761 | $1,589 | 0.42x | $12.66 | $5.35 |
| USA | $7,311 | $2,638 | 0.36x | $13.29 | $4.80 |

Brazil almost covers its costs and gets the smallest budget. The USA gets nearly double the spend of any other market and returns the least — $0.36 for every $1 spent.

### 2. Channel performance — top 5 by CTR

| Rank | Market | Channel | Impressions | Clicks | Spend | CTR | CPC |
|------|--------|---------|------------|--------|-------|-----|-----|
| 1 | Spain | TikTok | 25,973 | 1,040 | $1,303 | 4.00% | $1.25 |
| 2 | USA | Google | 68,839 | 2,376 | $2,490 | 3.45% | $1.05 |
| 3 | Spain | Facebook | 21,174 | 730 | $851 | 3.45% | $1.17 |
| 4 | Brazil | Google | 39,707 | 1,327 | $1,403 | 3.34% | $1.06 |
| 5 | USA | Facebook | 110,281 | 3,407 | $3,483 | 3.09% | $1.02 |

Spain TikTok leads with a 4.0% CTR, ahead of everything else. Brazil Facebook didn't make the top 5 by CTR (2.81%), but its CPC of $0.94 is the lowest of any channel — the most cost-efficient option for acquisition volume.

### 3. The retention problem

| Market | Subscriptions | Cancellations | Churn Rate | LTV (ARPU ÷ Churn) | CAC | LTV – CAC |
|--------|--------------|--------------|-----------|---------------------|-----|-----------|
| Brazil | 121 | 36 | 29.8% | $16.22 | $6.00 | +$10.22 |
| Spain | 55 | 13 | 23.6% | $22.64 | $12.66 | +$9.98 |
| USA | 103 | 33 | 32.0% | $14.97 | $13.29 | +$1.68 |

LTV is positive in every market, but the USA margin is only $1.68 per user — any rise in acquisition cost or churn pushes it negative. Spain has the lowest churn (23.6%) and the healthiest LTV despite similar subscription volumes, which suggests the Spanish user experience is doing something the other markets aren't.

---

## Recommendations

### 1. Reallocate budget toward what's working

Brazil has the best ROAS (0.80x) and the lowest CPC ($0.94 on Facebook) but the smallest budget. Shifting spend from the US to Brazil is the fastest way to improve overall return while retention gets fixed.

### 2. Find out what Spain is doing right

Spain has the best churn rate (23.6%) and the best creative performance (4.0% TikTok CTR). Audit those campaigns qualitatively. If better creative is attracting better-fit users, replicating it elsewhere could improve both CTR and retention.

### 3. Build a retention loop in the first week

Workout engagement runs around 50% across all markets, so the problem isn't motivation. it's habit formation. Users start but don't build a routine before losing interest.

**Action:** Design a structured 7-day onboarding sequence to build the habit loop before churn risk peaks.

### 4. Close the Spain revenue gap

Spain retains users better than any other market but posts a 0.42x ROAS — the second worst. Users stay, they just don't pay enough. That's a pricing or upsell problem, not a product problem.

**Action:** A/B test pricing tiers or introduce a premium plan for Spain, where willingness to stay is already proven.

---

## Summary

| Problem | Data Signal | Recommended Action |
|---------|------------|-------------------|
| USA: ROAS 0.36x | $7,311 spend → $2,638 revenue | Reduce budget, fix retention first |
| Brazil: underfunded | Best ROAS (0.80x), lowest CPC ($0.94) | Scale Facebook spend |
| Spain TikTok: 4.0% CTR | Best creative engagement in dataset | Audit and replicate in other markets |
| Global churn 24–32% | LTV below breakeven across all markets | 7-day onboarding challenge |
| Spain: low churn, low revenue | 23.6% churn but ROAS only 0.42x | Pricing audit / upsell test |

---

## Stack

- **PostgreSQL** — CTEs, joins, deduplication logic, aggregation views
- **SQL** — CPC / CTR / ROAS / LTV calculations at country × channel level
- **Tableau** — dashboard for exploring results by market and channel
