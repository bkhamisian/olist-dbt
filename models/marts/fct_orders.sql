with orders as (
    select * from {{ ref('int_orders_with_customers') }}
),

order_items as (
    select * from {{ ref('int_order_items_with_details') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_timestamp,
    o.order_delivered_carrier_timestamp,
    o.order_delivered_customer_timestamp,
    o.order_estimated_delivery_date,
    sum(oi.price)                                                                               as total_revenue,
    sum(oi.freight_value)                                                                       as total_freight,
    count(distinct oi.order_id || oi.order_item_id)                                             as total_items,
    datediff('day', o.order_purchase_timestamp, o.order_delivered_customer_timestamp) as delivery_time_days
from orders o
left join order_items oi
    on o.order_id = oi.order_id
group by 1, 2, 3, 4, 5, 6, 7, 8