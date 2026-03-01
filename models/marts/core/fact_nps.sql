{{ config(materialized='table') }}

with nps as (

    select
        survey_id,
        customer_id,
        order_id,
        survey_date,
        channel,
        nps_score,
        nps_label,
        comment
    from {{ ref('stg_nps_responses') }}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        order_month,
        channel          as order_channel,
        status,
        net_revenue
    from {{ ref('fact_orders') }}

),

customers as (

    select
        customer_id,
        customer_name,
        customer_city,
        customer_state,
        signup_date
    from {{ ref('fact_orders') }}
    group by
        customer_id,
        customer_name,
        customer_city,
        customer_state,
        signup_date

),

joined as (

    select
        n.survey_id,
        n.customer_id,
        n.order_id,
        c.customer_name,
        c.customer_city,
        c.customer_state,
        c.signup_date,
        o.order_date,
        o.order_month,
        n.survey_date,
        n.channel          as survey_channel,
        o.order_channel    as order_channel,
        n.nps_score,
        n.nps_label,
        n.comment,
        o.net_revenue
    from nps n
    left join orders o
        on n.order_id = o.order_id
    left join customers c
        on n.customer_id = c.customer_id

)

select * from joined