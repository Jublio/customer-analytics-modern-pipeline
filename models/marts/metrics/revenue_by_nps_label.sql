{{ config(materialized='view') }}

with base as (

    select
        order_month,
        nps_label,
        survey_channel,
        net_revenue
    from {{ ref('fact_nps') }}

),

aggregated as (

    select
        order_month,
        nps_label,
        survey_channel,
        count(*)                        as total_surveys,
        sum(net_revenue)                as total_net_revenue,
        avg(net_revenue)                as avg_net_revenue_per_survey
    from base
    group by
        order_month,
        nps_label,
        survey_channel

)

select * from aggregated