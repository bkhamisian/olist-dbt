with orders as (
    select *
    from {{ ref('fct_orders') }}
)

select
    customer_unique_id,
    cast(min(order_purchase_timestamp) as date) as first_order_date,
    count(order_id)                             as total_orders,
    sum(total_revenue + total_freight)          as total_spent,
    round(avg(delivery_time_days), 2)           as avg_delivery_time
from orders
group by 1