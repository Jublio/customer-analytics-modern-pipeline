{{ config(materialized='view') }}

with source as (

    select *
    from {{ ref('raw_nps_responses') }}

),

typed as (

    select
        cast(ssurvey_id as int64)          as survey_id,
        cast(customer_id as int64)        as customer_id,
        cast(order_id as int64)           as order_id,
        cast(survey_date as date)         as survey_date,
        upper(channel)                    as channel,
        cast(nps_score as int64)          as nps_score,
        upper(nps_label)                  as nps_label,
        comment

    from source

)

select * from typed