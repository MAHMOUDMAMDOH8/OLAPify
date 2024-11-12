{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='customer_sk',
        indexes=[
            {"columns":['customer_sk'],'unique':true}
        ],
        target_schema='staging_tables'
    )
}}

with valid_customers as (
    select 
        distinct customer_id,
        contact_name,
        contact_title,
        company_name,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax ,
        'northwind_db' as data_source
    from {{source('northwind_raw','customers')}}
    where 
        customer_id is not null
    and
        contact_name is not null
    and 
        contact_title is not null
    and
        company_name is not null
    and 
        address is not null
    and 
        postal_code is not null

)

select
    md5(customer_id || data_source ) as customer_sk,
    * 
from valid_customers