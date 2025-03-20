with order_items as (
    select  *
    from {{ ref('stg_order_items') }}
)

select  order_id,
        sum(price + freight_value) as total_value
from order_items
group by 1
having total_value < 0