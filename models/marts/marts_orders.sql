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
    o.customer_unique_id,
    o.customer_city,
    o.order_status,
    cast(o.order_purchase_timestamp as date)                                         as order_date,
    cast(o.order_delivered_customer_timestamp as date)                               as delivered_date,
    case when lower(o.order_status) = 'delivered' then
        date_diff(coalesce(cast(o.order_delivered_customer_timestamp as date),
                           o.order_estimated_delivery_date),
                  cast(o.order_purchase_timestamp as date), day) end                 as delivery_time_days,
    case when lower(o.order_status) = 'delivered' then
         case when coalesce(cast(o.order_delivered_customer_timestamp as date),
                           o.order_estimated_delivery_date) >
             o.order_estimated_delivery_date then 'Late' else 'On-Time' end
        else null end                                                                as delivery_status,
    round(sum(oi.price), 2)                                                          as total_order_value,
    count(distinct oi.product_id)                                                    as total_products,
    round(sum(oi.freight_value), 2)                                                  as total_freight,
    count(oi.order_id)                                                               as total_order_items,
    round((sum(oi.price) / NULLIF(count(oi.order_id), 0)), 2)                        as average_order_value,
    max(p.cnt_payment_types)                                                         as cnt_payment_types,
    max(p.total_revenue)                                                             as total_revenue,
    max(p.total_installments)                                                        as total_installments
from orders o
left join order_items oi
    on o.order_id = oi.order_id
left join payments p
    on o.order_id = p.order_id
group by 1, 2, 3, 4, 5, 6, 7, 8