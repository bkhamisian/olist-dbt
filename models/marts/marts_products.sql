with order_items as (
    select *
    from {{ ref('int_order_items_with_details') }}
)

select
    product_id,
    product_category_name,
    product_category_name_english,
    min(order_purchase_date)        as product_first_sold_date,
    count(order_id)                 as total_product_orders,
    sum(price)                      as total_revenue,
    round(avg(price), 2)            as avg_price
from order_items
group by 1, 2, 3