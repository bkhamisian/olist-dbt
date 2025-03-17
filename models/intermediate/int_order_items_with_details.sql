with order_items as (
    select *
    from {{ ref('stg_order_items') }}
),

products AS (
    select *
    from {{ ref('stg_products') }}
),

sellers AS (
    select *
    from {{ ref('stg_sellers') }}
)

select
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    p.product_category_name,
    p.product_category_name_english,
    s.seller_city,
    s.seller_state
from order_items oi
left join products p
    on oi.product_id = p.product_id
left join sellers s
    on oi.seller_id = s.seller_id