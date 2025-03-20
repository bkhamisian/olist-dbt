with payments as (
    select *
    from {{ ref('stg_order_payments') }}
)

select
    order_id,
    count(distinct payment_type) as cnt_payment_types,
    sum(payment_value)           as total_payment_value,
    count(payment_installments)  as total_installments,
    count(payment_sequential)    as total_payment_sequential
from payments
group by order_id