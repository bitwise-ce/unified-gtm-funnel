
-- fct_channel_funnel.sql
-- Final channel-level funnel table
-- Uses:
--   stg_ad_spend
--   stg_web_analytics
--   stg_opportunities

with ad as (
    select
        channel_name,
        sum(spend_usd)      as spend_usd,
        sum(impressions)    as impressions,
        sum(clicks)         as clicks
    from stg_ad_spend
    group by channel_name
),

web as (
    select
        channel_name,
        sum(sessions)       as sessions,
        sum(pageviews)      as pageviews,
        sum(conversions)    as conversions
    from stg_web_analytics
    group by channel_name
),

opp as (
    select
        channel_name,
        count(*)                        as total_opps,
        sum(is_closed_won)              as closed_won_opps,
        sum(case when is_closed_won = 1 then amount_usd else 0 end) as revenue_usd
    from stg_opportunities
    group by channel_name
),

all_channels as (
    -- union distinct list of channels present in any source
    select channel_name from ad
    union
    select channel_name from web
    union
    select channel_name from opp
)

select
    ac.channel_name,

    -- upper funnel
    coalesce(a.spend_usd, 0)         as spend_usd,
    coalesce(a.impressions, 0)       as impressions,
    coalesce(a.clicks, 0)            as clicks,

    -- mid funnel
    coalesce(w.sessions, 0)          as sessions,
    coalesce(w.pageviews, 0)         as pageviews,
    coalesce(w.conversions, 0)       as conversions,

    -- lower funnel
    coalesce(o.total_opps, 0)        as total_opps,
    coalesce(o.closed_won_opps, 0)   as closed_won_opps,
    coalesce(o.revenue_usd, 0)       as revenue_usd,

    -- derived metrics
    case
        when coalesce(a.impressions, 0) > 0
            then coalesce(a.clicks, 0) / a.impressions::float
        else null
    end as ctr,

    case
        when coalesce(a.clicks, 0) > 0
            then coalesce(a.spend_usd, 0) / a.clicks::float
        else null
    end as cpc,

    case
        when coalesce(w.sessions, 0) > 0
            then coalesce(w.conversions, 0) / w.sessions::float
        else null
    end as conversion_rate,

    case
        when coalesce(o.total_opps, 0) > 0
            then coalesce(o.closed_won_opps, 0) / o.total_opps::float
        else null
    end as win_rate,

    case
        when coalesce(a.spend_usd, 0) > 0
            then (coalesce(o.revenue_usd, 0) - a.spend_usd) / a.spend_usd::float
        else null
    end as roi

from all_channels ac
left join ad  a on ac.channel_name = a.channel_name
left join web w on ac.channel_name = w.channel_name
left join opp o on ac.channel_name = o.channel_name;
