with orders as (
    select *
    from {{ ref('marts_orders') }}
)

select
    customer_unique_id,
    cast(min(order_purchase_timestamp) as date)                as first_order_date,
    count(distinct cast(order_purchase_timestamp as date))     as cnt_distinct_order_days,
    count(order_id)                                            as total_orders,
    sum(total_order_value + total_freight)                     as total_spent,
    round(avg(delivery_time_days), 2)                          as avg_delivery_time,
    case when count(order_id) > 1 then true else false end     as is_repeat_customer
from orders
group by 1