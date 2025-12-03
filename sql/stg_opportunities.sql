-- stg_opportunities.sql
-- Assumes a raw table called `salesforce_opportunities`
-- loaded from data/salesforce_opportunities.csv

with source as (
    select
        opportunity_id,
        account_id,
        created_date::date                  as created_date,
        stage,
        amount_usd::number(14, 2)          as amount_usd,
        source                              as raw_source
    from salesforce_opportunities
),

with_flags as (
    select
        opportunity_id,
        account_id,
        created_date,
        stage,
        amount_usd,
        raw_source,
        case
            when lower(stage) = 'closed won' then 1
            else 0
        end as is_closed_won
    from source
),

with_channel as (
    select
        opportunity_id,
        account_id,
        created_date,
        stage,
        amount_usd,
        is_closed_won,
        -- normalize source into channel_name consistent with other models
        case lower(raw_source)
            when 'google ads' then 'Google Ads'
            when 'linkedin'   then 'LinkedIn'
            when 'meta'       then 'Meta'
            when 'facebook'   then 'Meta'
            when 'twitter'    then 'Twitter'
            when 'organic'    then 'Organic'
            when 'direct'     then 'Direct'
            else coalesce(initcap(raw_source), 'Other')
        end as channel_name
    from with_flags
)

select
    opportunity_id,
    account_id,
    created_date,
    channel_name,
    stage,
    amount_usd,
    is_closed_won
from with_channel;

