# unified-gtm-funnel

GTM funnel analytics exercise using sample ad spend, web analytics, and Salesforce opportunities data.

This repository contains:
- SQL models to clean and join the source data
- A simple channel-level funnel table
- Documentation of architectural decisions, metrics, and insights

---

## Repository structure

- `data/`
  - Source CSVs provided with the exercise:
    - `ad_spend.csv`
    - `web_analytics.csv`
    - `salesforce_opportunities.csv`

- `sql/`
  - `stg_ad_spend.sql` – staging model for ad spend data
  - `stg_web_analytics.sql` – staging model for web analytics / sessions data
  - `stg_opportunities.sql` – staging model for Salesforce opportunities
  - `fct_channel_funnel.sql` – final channel-level funnel table

- `docs/`
  - `step1_architecture_decisions.md`
  - `step2_dimensional_model_and_metrics.md`
  - `step3_future_priorities.md`
  - `step4_narrative_sales_ops_and_growth.md`
  - `step5_key_views.md`

---

## How to read this project

1. **Start with the docs:**
   - Step 1–3 (`docs/step1_*.md`, `step2_*.md`, `step3_*.md`) describe the data model design, metrics, and future work.
2. **Review the SQL models:**
   - `sql/` contains the staging models and the final `fct_channel_funnel` model.
3. **See the insights:**
   - Step 4 and Step 5 docs summarize key findings and the views that support them.

---

## Notes

- SQL is written in Snowflake-style SQL, but the logic is dialect-agnostic enough to be adapted.
- This repo focuses on modeling decisions, documentation, and communication, rather than full productionization.
