with olist_order_payments as (
    select *
    from {{ source('olist_data', 'order_payments') }}
),

cleaned_order_payments as (
    select
        order_id,
        cast(payment_sequential as integer)     as payment_sequential,
        payment_type,
        cast(payment_installments as integer)   as payment_installments,
        cast(payment_value as float)            as payment_value
    from olist_order_payments
)

select *
from cleaned_order_payments