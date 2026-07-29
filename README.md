# Fitness App Analytics: Unit Economics & Product Funnel Audit

View Tableau Dashboard:https://public.tableau.com/views/Fitnessapp_17793454772490/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link


## Overview

A global fitness app was spending more on user acquisition than it was earning back. I was brought in to clean the data, calculate the unit economics and identify where the model was breaking down.

The data came from two separate systems — AppsFlyer and internal transaction records.

---

## What I Built

A analytics pipeline in PostgreSQL that standardizes and joins the data, then surfaces key performance metrics in SQL views ready for Tableau.

**Technical decisions:**
- Used CTEs throughout to keep the SQL modular and readable 
- Deduplicated transaction records with logic-based filtering to get accurate revenue numbers
- Standardized country names and device types across both data sources
- Joined marketing spend with user behavior to calculate CPC, CTR, and ROAS at the country × channel level

---

## Key Findings

### 1. Every market is running at a loss 

ROAS is shown as a multiplier: **1.0x = break-even**, anything below means money is being lost.

| Market | Total Spend | Total Revenue | ROAS | CAC | ARPU |
|--------|------------|--------------|------|-----|------|
| 🇧🇷 Brazil | $3,704 | $2,978 | **0.80x** | $6.00 | $4.83 |
| 🇪🇸 Spain | $3,761 | $1,589 | 0.42x | $12.66 | $5.35 |
| 🇺🇸 USA | $7,311 | $2,638 | 0.36x | $13.29 | $4.80 |

Brazil is the closest to break-even and receives the least budget. The USA absorbs nearly **double the spend** of any other market but has the worst return — $0.36 back for every $1 spent.

### 2. Channel performance — Top 5 by CTR

| Rank | Market | Channel | Impressions | Clicks | Spend | CTR | CPC |
|------|--------|---------|------------|--------|-------|-----|-----|
| 1 | 🇪🇸 Spain | TikTok | 25,973 | 1,040 | $1,303 | **4.00%** | $1.25 |
| 2 | 🇺🇸 USA | Google | 68,839 | 2,376 | $2,490 | 3.45% | $1.05 |
| 3 | 🇪🇸 Spain | Facebook | 21,174 | 730 | $851 | 3.45% | $1.17 |
| 4 | 🇧🇷 Brazil | Google | 39,707 | 1,327 | $1,403 | 3.34% | $1.06 |
| 5 | 🇺🇸 USA | Facebook | 110,281 | 3,407 | $3,483 | 3.09% | $1.02 |

Spain TikTok leads with a **4.0% CTR** — noticeably ahead of everything else. Worth noting: Brazil Facebook didn't make the top 5 by CTR (2.81%), but it has the **lowest CPC across all channels at $0.94**, which makes it the most cost-efficient channel for pure acquisition volume.

### 3. The retention problem

| Market | Subscriptions | Cancellations | Churn Rate | LTV (ARPU ÷ Churn) | CAC | LTV – CAC |
|--------|--------------|--------------|-----------|---------------------|-----|-----------|
| 🇧🇷 Brazil | 121 | 36 | 29.8% | $16.22 | $6.00 | **+$10.22** |
| 🇪🇸 Spain | 55 | 13 | **23.6%** | $22.64 | $12.66 | **+$9.98** |
| 🇺🇸 USA | 103 | 33 | 32.0% | $14.97 | $13.29 | ⚠️ **+$1.68** |

LTV is positive across all markets — but the USA margin is razor-thin at **$1.68 per user**. Any increase in acquisition costs or churn pushes it into negative territory. Spain has the lowest churn (23.6%) and the healthiest LTV, despite similar subscription volumes — something about the Spanish user experience is building loyalty the other markets don't have.

---

## Recommendations

### 1. Reallocate budget toward what's working

Brazil has the best ROAS (0.80x) and the lowest CPC ($0.94 on Facebook) — yet it's the most underfunded market. Shifting budget from the US to Brazil is the fastest path to improving overall return while retention fixes are being built.

### 2. Figure out what Spain is doing right

Spain has the best churn rate (23.6%) and the best creative performance (4.0% TikTok CTR). Run a qualitative audit of those campaigns — if better creative attracts better-fit users, replicating it in other markets could improve both CTR and retention simultaneously.

### 3. Build a retention loop in the first week

The data shows ~50% workout engagement across all markets, which means the problem isn't motivation — it's habit formation. Users start but don't build a routine before losing interest.

**Action:** Design a structured 7-day onboarding sequence for new subscribers to create a behavioral loop before churn risk peaks.


### 4. Close the Spain revenue gap

Spain retains users better than anyone but has a 0.42x ROAS — the second worst. Users stay, they just aren't paying enough. This points to a pricing or upsell problem, not a product problem.

**Action:** A/B test pricing tiers or introduce a premium plan for Spain, where willingness-to-stay is already demonstrated by the data.

---

## Summary

| Problem | Data Signal | Recommended Action |
|---------|------------|-------------------|
| USA: ROAS 0.36x | $7,311 spend → $2,638 revenue | Reduce budget, fix retention first |
| Brazil: underfunded | Best ROAS (0.80x), lowest CPC ($0.94) | Scale Facebook spend |
| Spain TikTok: 4.0% CTR | Best creative engagement in dataset | Audit + replicate in other markets |
| Global churn 24–32% | LTV below breakeven across all markets | 7-day onboarding challenge |
| Spain: low churn, low revenue | 23.6% churn but ROAS only 0.42x | Pricing audit / upsell test |

---

## Stack

`PostgreSQL` · `CTEs`  · `AppsFlyer` · `Tableau` · `Unit Economics Modeling`
