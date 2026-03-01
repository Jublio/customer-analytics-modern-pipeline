{{ config(materialized='table') }}

with customers as (

    select
        customer_id,
        customer_name,
        email,
        city,
        state,
        signup_date
    from {{ ref('stg_customers') }}

),

orders_agg as (

    select
        customer_id,
        min(order_date)                       as first_order_date,
        max(order_date)                       as last_order_date,
        count(*)                              as total_orders,
        sum(net_revenue)                      as total_net_revenue
    from {{ ref('stg_orders') }}
    where status = 'DELIVERED'
    group by customer_id

),

final as (

    select
        c.customer_id,
        c.customer_name,
        c.email,
        c.city              as customer_city,
        c.state             as customer_state,
        c.signup_date,
        o.first_order_date,
        o.last_order_date,
        o.total_orders,
        o.total_net_revenue,
        -- regra simples de cliente ativo: fez pedido nos últimos 60 dias
        case
            when o.last_order_date >= date_sub(current_date(), interval 60 day)
                then true
            else false
        end as is_active_60d
    from customers c
    left join orders_agg o
        on c.customer_id = o.customer_id

)

select * from final