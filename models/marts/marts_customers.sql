with orders as (
    select *
    from {{ ref('marts_orders') }}
),

customer_details as (
    select
        customer_unique_id,
        min(order_date)                                                 as first_order_date,
        max(order_date)                                                 as last_order_date,
        count(distinct order_date)                                      as cnt_distinct_order_days,
        count(order_id)                                                 as total_orders,
        round(coalesce(sum(total_order_value + total_freight), 0), 2)   as customer_lifetime_value,
        round(avg(delivery_time_days), 2)                               as avg_delivery_time
from orders
where lower(order_status)
          not in ('canceled', 'unavailable')
group by 1
),

customer_retention AS (
    SELECT
        date_trunc(first_order_date, month)                                    as cohort_month,
        count(distinct customer_unique_id)                                     as total_customers,
        count(distinct case when total_orders > 1 then customer_unique_id end) as retained_customers
    from customer_details
    group by 1
)

select
    cd.customer_unique_id,
    cd.first_order_date,
    cd.last_order_date,
    cd.cnt_distinct_order_days,
    cd.total_orders,
    cd.customer_lifetime_value,
    cd.avg_delivery_time,
    round(cr.retained_customers/ cr.total_customers, 2)        as customer_retention_rate,
    round(1 - (cr.retained_customers / cr.total_customers), 2) as customer_churn_rate
from customer_details cd
inner join customer_retention cr
    on date_trunc(cd.first_order_date, month) = cr.cohort_month