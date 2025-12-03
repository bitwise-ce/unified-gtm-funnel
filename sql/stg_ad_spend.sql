-- stg_ad_spend.sql
-- Assumes a raw table called `ad_spend` loaded from data/ad_spend.csv

with source as (
    select
        -- cast types from the raw CSV
        date::date                    as date,
        campaign_id,
        channel                       as channel_name,
        utm_source,
        utm_campaign,
        spend_usd::number(12, 2)      as spend_usd,
        clicks::number                as clicks,
        impressions::number           as impressions
    from ad_spend
),

normalized as (
    select
        date,
        campaign_id,
        utm_source,
        utm_campaign,
        spend_usd,
        clicks,
        impressions,
        -- normalize channel naming for consistency
        case lower(channel_name)
            when 'google ads' then 'Google Ads'
            when 'meta'       then 'Meta'
            when 'twitter'    then 'Twitter'
            when 'linkedin'   then 'LinkedIn'
            else channel_name
        end as channel_name
    from source
)

select
    date,
    channel_name,
    campaign_id,
    utm_source,
    utm_campaign,
    spend_usd,
    clicks,
    impressions
from normalized;

