with olist_products as (
    select *
    from {{ source('olist_data', 'products') }}
),

cleaned_products as (
    select
        op.product_id,
        op.product_category_name,
        pcnt.product_category_name_english,
        CAST(op.product_name_lenght as int64)        as product_name_length,
        CAST(op.product_description_lenght as int64) as product_description_length,
        CAST(op.product_photos_qty as int64)         as product_photos_qty,
        CAST(op.product_weight_g as float64)         as product_weight_g,
        CAST(op.product_length_cm as float64)        as product_length_cm,
        CAST(op.product_height_cm as float64)        as product_height_cm,
        CAST(op.product_width_cm as float64)         as product_width_cm
    from olist_products as op
    left join {{ ref('product_category_name_translation') }} as pcnt
        on lower(op.product_category_name) = lower(pcnt.product_category_name)
)

select *
from cleaned_products