
  
  create view "olist"."dev_reporting"."test_customers__dbt_tmp" as (
    -- models/example/test_customers.sql
select *
from "olist"."olist_data"."customers"
  );
