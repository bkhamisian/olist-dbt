with olist_geolocation as (
    select *
    from {{ source('olist_data', 'geolocation') }}
),

cleaned_geolocation as (
    select
        geolocation_zip_code_prefix,
        cast(geolocation_lat as float)      as geolocation_lat,
        cast(geolocation_lng as float)      as geolocation_lng,
        geolocation_city,
        cast(geolocation_state as char(2))  as geolocation_state
    from olist_geolocation
)

select *
from cleaned_geolocation