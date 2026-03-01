{{ config(materialized='view') }}

with source as (

    select * 
    from {{ source('raw', 'raw_customers') }}

),

renamed as (

    select
        customer_id,
        full_name as customer_name,
        lower(email) as email,
        cast(birth_date as date) as birth_date,
        city,
        state,
        cast(signup_date as date) as signup_date,
        signup_channel

    from source

)

select * from renamed