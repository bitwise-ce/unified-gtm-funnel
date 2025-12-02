# Step 1 – Architectural Decisions & Rationale

## Overview

The goal of this project is to build a simple, reliable, and interpretable GTM funnel model linking:
- Paid advertising activity  
- Web engagement & conversions  
- Salesforce opportunity creation and revenue  

The architecture is intentionally lightweight. It avoids tooling choices (e.g., dbt, Snowflake warehouse setup) and instead focuses on *clear modeling decisions*, *reproducibility*, and *analytical transparency*.

---

## Why a Layered Model?

Although this exercise could be done in a single SQL script, using a layered approach offers clarity:

### **1. Staging Layer (`stg_*` SQL models)**
Purpose:
- Standardize column names  
- Normalize data types  
- Apply minimal cleaning  
- Prepare each table for joining  

Outcome:
- Each dataset becomes consistent and join-ready  
- Logic is separated from business definitions

---

## 2. Final Data Model (Channel-level Funnel Table)

The final model (`fct_channel_funnel`) combines key metrics from:
- Ad spend  
- Web analytics  
- Salesforce opportunities  

This model is kept at a **channel grain** to:
- Reduce attribution ambiguity  
- Allow consistent comparison across datasets  
- Provide a clear funnel from impressions → revenue

This architectural choice reflects the limited joins available in the sample data (no user-level identifiers), making channel-level aggregation the most consistent and defendable structure.

---

## Design Priorities

1. **Transparency over complexity**  
   The SQL is written to be readable and easily audited. Each transformation is separated logically.

2. **Reproducibility**  
   Keeping CSVs in the repo ensures the model can be re-run or extended by anyone.

3. **Cross-team clarity**  
   The final funnel table is designed with two audiences in mind:
   - *Sales Ops* (pipeline and revenue quality by channel)
   - *Growth* (upper and mid-funnel performance)

4. **Extensibility**  
   The structure anticipates future additions such as:
   - campaign-level attribution  
   - cohorting by date or segment  
   - additional behavioral features  

More details on the dimensional model and metric definitions appear in **Step 2**.

