with order_items as (
    select *
    from {{ ref('int_order_items_with_details') }}
)

select
    product_id,
    product_category_name,
    product_category_name_english,
    min(order_purchase_date)                                          as product_first_sold_date,
    count(case when lower(order_status)
          not in ('canceled', 'unavailable') then order_id end)       as total_product_orders,
    coalesce(round(sum(case when lower(order_status)
          not in ('canceled', 'unavailable') then price end), 2), 0)  as total_price,
    coalesce(round(avg(case when lower(order_status)
          not in ('canceled', 'unavailable') then price end), 2), 0)  as avg_price
from order_items
group by 1, 2, 3