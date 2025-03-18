with olist_order_payments as (
    select *
    from {{ source('olist_data', 'order_payments') }}
),

cleaned_order_payments as (
    select
        order_id,
        cast(payment_sequential as int64)    as payment_sequential,
        payment_type,
        cast(payment_installments as int64)  as payment_installments,
        cast(payment_value as float64)       as payment_value
    from olist_order_payments
)

select *
from cleaned_order_payments