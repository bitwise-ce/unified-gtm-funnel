-- stg_web_analytics.sql
-- Assumes a raw table called `web_analytics` loaded from data/web_analytics.csv

with source as (
    select
        session_id,
        user_id,
        session_date::date              as session_date,
        landing_page,
        utm_source,
        utm_medium,
        utm_campaign,
        pageviews::number               as pageviews,
        conversions::number             as conversions
    from web_analytics
),

aggregated as (
    -- Aggregate to channel + date level to align with ad spend and simplify the funnel
    select
        session_date,
        utm_source,
        utm_campaign,
        count(distinct session_id)      as sessions,
        sum(pageviews)                  as pageviews,
        sum(conversions)                as conversions
    from source
    group by
        session_date,
        utm_source,
        utm_campaign
),

with_channel as (
    select
        session_date,
        utm_source,
        utm_campaign,
        sessions,
        pageviews,
        conversions,
        -- normalize utm_source into a consistent channel_name
        case lower(utm_source)
            when 'google'   then 'Google Ads'
            when 'facebook' then 'Meta'
            when 'meta'     then 'Meta'
            when 'twitter'  then 'Twitter'
            when 'linkedin' then 'LinkedIn'
            when 'organic'  then 'Organic'
            when 'direct'   then 'Direct'
            else coalesce(initcap(utm_source), 'Other')
        end as channel_name
    from aggregated
)

select
    session_date,
    channel_name,
    utm_source,
    utm_campaign,
    sessions,
    pageviews,
    conversions
from with_channel;
