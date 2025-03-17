with olist_sellers as (
    select *
    from {{ source('olist_data', 'sellers') }}
),

cleaned_sellers as (
    select
        seller_id,
        seller_zip_code_prefix,  --Keeping it as a varchar because storing it as an integer would remove the leading zeros.
        seller_city,
        cast(seller_state as char(2))  as seller_state
    from olist_sellers
)

select *
from cleaned_sellers