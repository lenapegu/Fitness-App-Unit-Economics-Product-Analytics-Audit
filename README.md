# Fitness App Analytics: Unit Economics & Product Funnel Audit

## Project Objective
The goal of this project was to analyze the marketing and product performance of a global fitness mobile application. The business was facing profitability issues, and I was tasked with identifying why the current **LTV < CAC** model was failing and providing a data-driven roadmap to reach a break-even point.

---

## Methodology & Approach (STAR Framework)

### **S (Situation): The Business Problem**
Marketing and product data were fragmented across different sources (AppsFlyer logs and internal transaction databases). The data was "dirty" (duplicates, inconsistent naming), making it impossible for the management to see the true cost of user acquisition and the actual lifetime value of users.

### **T (Task): The Analytical Goal**
My responsibility was to build a clean data pipeline in PostgreSQL to:
1. Standardize and clean marketing and product event data.
2. Calculate core Unit Economics metrics: **CAC, LTV, ROAS, and Churn Rate**.
3. Design analytical views (SQL Views) optimized for BI tools (Tableau).

### **A (Action): Technical Implementation**
* **Data Preparation:** Used **Common Table Expressions (CTEs)** to create a modular and readable SQL architecture, avoiding complex nested subqueries.
* **Deduplication:** Identified and removed duplicate transaction records using logic-based filtering within CTEs to ensure revenue accuracy.
* **Normalization:** Standardized inconsistent dimensions (country names, device types) to enable cross-regional comparisons.
* **Metric Modeling:** Joined marketing spend data with user behavior logs to calculate granular performance ratios (CPC, CTR, ROAS) at the country and channel levels.

---

## Key Findings

### **1. Marketing Efficiency Paradox**
The analysis revealed a critical insight: **the problem is not the marketing costs, but the post-click behavior.**
* **Brazil (The Efficiency Leader):** Facebook is the "Golden Goose" with the lowest CPC (**$0.94**), driving the highest ROAS (**80%**).
* **Spain (The Engagement Leader):** TikTok achieved the highest creative resonance with a **4.0% CTR**.
* **USA (The Burn Rate):** Despite a stable CTR (3.45%) and a reasonable CPC (~$1.00), the **ROAS is only 36%**. We are "pouring money into a fire" in the US market.

### **2. Product Health: The "Leaky Bucket"**
 **Critical Churn:** The overall **Churn Rate is 39%** in the USA and Brazil. 
**Insight:** Users are clicking and joining at market rates, but they are leaving the app before the company can recoup acquisition costs (CAC $38.68 in the USA).

---

##  Summary & Strategic Recommendations
The business does not have a "marketing problem," but a **"retention problem."**


Based on the data-driven audit, the project reveals that while marketing acquisition is functioning efficiently, the business model is currently unsustainable due to a "leaky bucket" product effect. To reach the break-even point and achieve long-term growth, I recommend the following three-pillar strategy:

1. **Strategic Budget Reallocation (Marketing)**
Scale the "Brazil Success": Immediately reallocate 40% of the underperforming USA budget to Brazil. With a CAC of $19.29 and the lowest CPC ($0.94) on Facebook, Brazil is the primary candidate for achieving a positive ROI in the shortest timeframe.

Creative Optimization via Spain: Leverage the high 4.0% CTR on TikTok Spain. I recommend conducting a creative audit of the Spanish TikTok campaigns to replicate their visual style in other regions, as it shows the highest potential for lowering overall CPC through engagement.

2. **Retention-First Product Roadmap**
The "Golden Window" Onboarding: Since 80% of users start a workout but 39% churn quickly, the first 48 hours are critical. I recommend implementing a "7-Day Kickstart Challenge" for all new subscribers to build an immediate exercise habit and reduce early-stage churn.

CRM & Push-Notification Strategy: Develop a trigger-based notification system targeting users who haven't logged a workout for 2 consecutive days. My analysis shows that reducing the Churn Rate from 39% to 20% will double the LTV, making even the high-CAC USA market viable.

3.**Monetization Pivot**
USA Funnel Audit: The massive gap between USA acquisition costs ($38.68) and revenue ($13.96) suggests a mismatch between user expectations and the subscription value. I recommend an A/B price test or introducing a "Trial Period" for the US market to improve the Conversion-to-Paid ratio.

Spain Loyalty Study: Investigate why Spain has the lowest Churn Rate (27%) despite lower initial engagement. Understanding this "loyalty factor" is the key to fixing the global retention issue.


