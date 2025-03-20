with orders as (
    select *
    from {{ ref('int_orders_with_customers') }}
),

order_items as (
    select *
    from {{ ref('int_order_items_with_details') }}
),

payments as (
    select *
    from {{ ref('int_order_payments') }}
)

select
    o.order_id,
    o.customer_id,
    o.customer_unique_id,
    o.order_status,
    o.order_purchase_timestamp,
    cast(o.order_purchase_timestamp as date)                                         as order_date,
    o.order_approved_timestamp,
    o.order_delivered_carrier_timestamp,
    o.order_delivered_customer_timestamp,
    o.order_estimated_delivery_date,
    max(p.cnt_payment_types)                                                         as cnt_payment_types,
    max(total_payment_sequential)                                                    as total_payment_sequential,
    sum(oi.price)                                                                    as total_order_value,
    count(oi.product_id)                                                             as total_products,
    sum(oi.freight_value)                                                            as total_freight,
    count(oi.order_id)                                                               as total_order_items,
    max(total_payment_value)                                                         as total_payment_value,
    max(total_installments)                                                          as total_installments,
    date_diff(o.order_delivered_customer_timestamp, o.order_purchase_timestamp, day) as delivery_time_days
from orders o
left join order_items oi
    on o.order_id = oi.order_id
left join payments p
    on o.order_id = p.order_id
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10