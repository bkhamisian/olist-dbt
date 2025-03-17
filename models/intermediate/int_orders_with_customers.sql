with orders as (
    select *
    from {{ ref('stg_orders') }}
),

customers AS (
    select *
    from {{ ref('stg_customers') }}
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
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
from orders o
left join customers c
    on o.customer_id = c.customer_id