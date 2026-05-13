# Fitness App Analytics: Unit Economics & Product Funnel Audit

## Overview

A global fitness app was losing money on every user it acquired. CAC exceeded LTV across key markets, and no one could explain exactly why. I was brought in to find where the model was breaking down and map a clear path to profitability.

---

## The Problem

Marketing and product data lived in separate systems — AppsFlyer logs on one side, internal transaction records on the other. The data was messy: duplicates, inconsistent country names, mixed device formats. As a result, the team had no reliable view of what acquiring a user actually cost, or how much that user was worth over time.

---

## What I Built

A clean analytics pipeline in PostgreSQL, designed to answer three questions:
- What does it actually cost to acquire a user in each market and channel?
- How much revenue does that user generate before they churn?
- Where exactly is the model breaking?

**Technical approach:**
- Used CTEs to keep the SQL modular and readable — no deeply nested subqueries
- Deduplicated transaction records using logic-based filtering to get accurate revenue figures
- Standardized country names and device types to make cross-regional comparisons valid
- Joined marketing spend with behavioral data to calculate CPC, CTR, and ROAS at country and channel level
- Built SQL views optimized for Tableau dashboards

---

## Key Findings

### The marketing is not the problem

This was the central insight of the whole project.

| Market | Channel | CPC | CTR | ROAS | CAC |
|--------|---------|-----|-----|------|-----|
| 🇧🇷 Brazil | Facebook | $0.94 | — | 80% | $19.29 |
| 🇪🇸 Spain | TikTok | — | 4.0% | — | — |
| 🇺🇸 USA | Facebook | ~$1.00 | 3.45% | 36% | $38.68 |

**Brazil** is the standout market — lowest CPC, highest ROAS, lowest CAC. The only market where the unit economics are close to working.

**Spain** shows the strongest creative performance. A 4.0% CTR on TikTok means the content is genuinely resonating — this isn't just good targeting, it's good creative.

**USA** is the core issue. The click metrics look normal. The CPC is reasonable. But ROAS is only 36% and CAC is $38.68 against revenue of $13.96 per user. The ads are doing their job — the product isn't holding users long enough to recoup the spend.

### Users are leaving before the company can break even

Churn Rate in both the USA and Brazil sits at **39%**. Nearly 4 in 10 users leave before the business recovers its acquisition cost. This is a product problem, not a marketing problem.

---

## Recommendations

### 1. Shift budget toward what's working

Reallocate 40% of the US marketing budget to Brazil. With a CAC of $19.29 and ROAS of 80%, Brazil is the strongest near-term path to positive ROI.

Run a creative audit on the Spanish TikTok campaigns. A 4.0% CTR doesn't happen by accident — understanding what's driving it is an opportunity to lower CPC across all markets by improving engagement rates.

### 2. Fix the onboarding window

80% of users start a workout. 39% churn shortly after. The product is getting users in the door but not building a habit before they lose interest.

**Recommendation:** Launch a "7-Day Kickstart Challenge" for all new subscribers — a structured sequence designed to create a workout habit in the first week, before churn risk peaks.

**Recommendation:** Build a trigger-based push notification system for users who haven't logged a workout in 2 consecutive days. Reducing Churn Rate from 39% to 20% would double LTV — making even the high-CAC US market viable.

> LTV = ARPU ÷ Churn Rate
> At 39% churn → LTV = ARPU / 0.39
> At 20% churn → LTV = ARPU / 0.20 (~2x increase)

### 3. Revisit US monetization

The gap between US CAC ($38.68) and revenue per user ($13.96) is too wide to fix with retention alone. There's likely a conversion problem — users aren't upgrading to paid at the rate they should be.

**Recommendation:** A/B test pricing or introduce a free trial period for the US market to reduce the friction to paid conversion.

**Open question — Spain:** Spain has the lowest Churn Rate (27%) despite not having the highest initial engagement. Something about the Spanish user experience is driving loyalty that doesn't exist elsewhere. Understanding this is probably the highest-leverage research project for fixing global retention.

---

## Impact Summary

| Problem | Root Cause | Recommended Fix |
|---------|-----------|-----------------|
| LTV < CAC in USA | High churn before payback | 7-day onboarding challenge + push re-engagement |
| Low ROAS in USA (36%) | Poor retention, not poor acquisition | Retention-first product roadmap |
| Underutilized Brazil market | Budget misallocation | Reallocate 40% of US budget |
| High CPC in other markets | Weak creative engagement | Replicate Spain TikTok creative approach |

---

## Tools & Stack

`PostgreSQL` `CTEs` `Window Functions` `Tableau` `AppsFlyer` `Unit Economics Modeling`
