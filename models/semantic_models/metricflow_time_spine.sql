with days as (
    {{dbt.date_spine(
        'day',
        "DATE(2016,01,01)",
        "DATE(2019,01,01)"
    )
    }}
),

final as (
    select cast(date_day as date) as date_day
    from days
)

select *
from final


{#with recursive date_spine as (#}
{#    select cast('2016-01-01' as date) AS date_day#}
{#    union all#}
{#    select date_add(date_day, interval 1 day)#}
{#    from date_spine#}
{#    where date_day < '2018-12-31'#}
{#)#}
{#select date_day#}
{#from date_spine#}
{#order by date_day#}