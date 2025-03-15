-- models/example/test_customers.sql
select *
from {{ source('olist_data', 'customers') }}
