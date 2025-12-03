# Step 3 – What I’d Prioritize Next With More Time

This project focuses on building a clear, channel-level GTM funnel using the sample datasets.  
With more time and access to richer data, here are the improvements and next priorities I would tackle:

---

## 1. Introduce Campaign- and Ad-Level Attribution
The current model aggregates performance at the channel level because the datasets do not share joinable campaign or user identifiers.  
With more granular attribution fields (campaign_id, ad_group, creative), I would extend the model to:

- attribute spend and conversions at a campaign level  
- compare ROI and CAC across specific tactics  
- identify high-performing versus inefficient campaigns  

This would turn the funnel from directional → fully actionable.

---

## 2. Add User- or Session-Level Identity Resolution
The provided data offers no mechanism for tying sessions → leads → opportunities.  
If lead/contact IDs or hashed emails were available, I would:

- attribute opportunities back to originating sessions or campaigns  
- move from channel-level inference to person-level attribution  
- build multi-touch attribution models (first-touch, last-touch, position-based)

This unlocks accurate pipeline influence analytics.

---

## 3. Introduce Time-Based Logic (Cohorts, Lag Windows)
Today’s funnel aligns metrics at the channel level without temporal constraints.  
With expanded scope, I would:

- cohort users by session month or acquisition date  
- apply reasonable attribution lag (e.g., session → opp creation within 30–60 days)  
- study conversion time between funnel stages  

This would show how long channels take to convert and where bottlenecks exist.

---

## 4. Clean & Normalize Channel Naming Conventions
Real marketing data often includes inconsistent naming (e.g., “google / cpc” vs. “google ads”).  
With more time, I would:

- build a robust channel taxonomy  
- centralize UTM parsing rules  
- apply canonical mappings to ensure reliable cross-system alignment  

This improves reporting accuracy and maintainability.

---

## 5. Add Quality Metrics Beyond Volume
Today’s funnel measures pipeline and revenue. With deeper data, I would:

- analyze opportunity quality (stage progression, ACV, win probability)  
- measure qualified pipeline (e.g., SQLs, SAOs)  
- segment performance by region, product, or customer type  

This improves alignment with Sales and Leadership.

---

## 6. Build Dashboards for Growth + Sales Ops
Finally, after hardening the data model, I would build dashboards that visualize:

- channel-level efficiency trends  
- spend vs. pipeline lift  
- conversion rates across each funnel stage  
- revenue contribution by channel  

This enables both teams to understand performance and make decisions quickly.

---

Over

