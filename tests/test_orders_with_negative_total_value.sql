-- Fix this test

{#dbt test                  # Run all tests#}
{#dbt test --select source:olist#}
{#dbt test --select test_type:generic  # Run only generic tests#}
{#dbt test --select model_name  # Run tests for a specific model#}
{#dbt test --select assert_stg_order_items_values_positive#}

with order_items as (
    select  *
    from {{ ref('stg_order_items') }}
)

select  order_id,
        sum(price + freight_value) as total_value
from order_items
having total_value < 0