with order_items as (
    select *
    from {{ ref('int_order_items_with_details') }}
)

select
    seller_id,
    seller_city,
    min(order_purchase_date)                                   as first_sale_date,
    count(case when lower(order_status)
           in ('shipped', 'delivered') then order_id end)      as total_seller_orders,
    count(distinct case when lower(order_status) = 'delivered'
        then product_id end)                                   as unique_products_sold
from order_items
group by 1, 2