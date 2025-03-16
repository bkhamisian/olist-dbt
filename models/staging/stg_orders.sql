with olist_orders as (
    select *
    from {{ source('olist_data', 'orders') }}
),

cleaned_orders as (
    select
        order_id,
        customer_id,
        order_status,
        cast(order_purchase_timestamp as timestamp)        as order_purchase_timestamp,
        cast(order_approved_at as timestamp)               as order_approved_timestamp,
        cast(order_delivered_carrier_date as timestamp)    as order_delivered_carrier_timestamp,
        cast(order_delivered_customer_date as timestamp)   as order_delivered_customer_timestamp,
        cast(order_estimated_delivery_date as date)        as order_estimated_delivery_date
    from olist_orders
)

select *
from cleaned_orders