with olist_order_items as (
    select *
    from {{ source('olist_data', 'order_items') }}
),

cleaned_order_items as (
    select
        order_id,
        cast(order_item_id as int64)            as order_item_id,
        product_id,
        seller_id,
        cast(shipping_limit_date as timestamp)  as shipping_limit_timestamp,
        cast(price as float64)                  as price,
        cast(freight_value as float64)          as freight_value
    from olist_order_items
)

select *
from cleaned_order_items