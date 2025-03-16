with olist_customers as (
    select *
    from {{ source('olist_data', 'customers') }}
),

cleaned_customers as (
    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix, --Keeping it as a varchar because storing it as an integer would remove the leading zeros.
        customer_city,
        cast(customer_state as char(2)) as customer_state
    from olist_customers
)

select *
from cleaned_customers