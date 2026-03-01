{{ config(materialized='view') }}

with source as (

    select *
    from {{ ref('raw_orders') }}

),

typed as (

    select
        cast(order_id as int64)           as order_id,
        cast(customer_id as int64)        as customer_id,
        cast(order_date as date)          as order_date,
        upper(channel)                    as channel,
        upper(status)                     as status,
        cast(gross_revenue as numeric)    as gross_revenue,
        cast(discount as numeric)         as discount,
        cast(net_revenue as numeric)      as net_revenue

    from source

)

select * from typed