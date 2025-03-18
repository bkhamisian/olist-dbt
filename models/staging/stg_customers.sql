with olist_customers as (
    select *
    from {{ source('olist_data', 'customers') }}
),

cleaned_customers as (
    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    from olist_customers
)

select *
from cleaned_customers