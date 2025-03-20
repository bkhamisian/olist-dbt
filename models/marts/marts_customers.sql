with orders as (
    select *
    from {{ ref('marts_orders') }}
)

select
    customer_unique_id,
    min(order_date)                                                 as first_order_date,
    count(distinct order_date)                                      as cnt_distinct_order_days,
    count(order_id)                                                 as total_orders,
    round(coalesce(sum(total_order_value + total_freight), 0), 2)   as total_spent,
    round(avg(delivery_time_days), 2)                               as avg_delivery_time,
    case when count(order_id) > 1 then true else false end          as is_repeat_customer
from orders
where lower(order_status)
          not in ('canceled', 'unavailable')
group by 1