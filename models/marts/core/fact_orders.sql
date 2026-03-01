{{ config(materialized='table') }}

with orders as (

    select
        o.order_id,
        o.customer_id,
        o.order_date,
        date_trunc(o.order_date, month) as order_month,
        o.channel,
        o.status,
        o.gross_revenue,
        o.discount,
        o.net_revenue
    from {{ ref('stg_orders') }} as o
    where o.status = 'DELIVERED'

),

customers as (

    select
        c.customer_id,
        c.customer_name,
        c.city        as customer_city,
        c.state       as customer_state,
        c.signup_date
    from {{ ref('stg_customers') }} as c

),

joined as (

    select
        o.order_id,
        o.customer_id,
        c.customer_name,
        c.customer_city,
        c.customer_state,
        c.signup_date,
        o.order_date,
        o.order_month,
        o.channel,
        o.status,
        o.gross_revenue,
        o.discount,
        o.net_revenue,
        date_diff(o.order_date, c.signup_date, day) as customer_tenure_days
    from orders o
    left join customers c
        on o.customer_id = c.customer_id

)

select * from joined