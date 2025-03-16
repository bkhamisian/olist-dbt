with olist_geolocation as (
    select *
    from {{ source('olist_data', 'geolocation') }}
),

cleaned_geolocation as (
    select
        geolocation_zip_code_prefix, --Keeping it as a varchar because storing it as an integer would remove the leading zeros.
        cast(geolocation_lat as float)      as geolocation_lat, -- Correct, ranges from -90 to +90. Small rounding will likely not affect the analysis in case used.
        cast(geolocation_lng as float)      as geolocation_lng, -- Correct, ranges from -180 to +180. Small rounding will likely not affect the analysis in case used.
        geolocation_city,
        cast(geolocation_state as char(2))  as geolocation_state
    from olist_geolocation
)

select *
from cleaned_geolocation