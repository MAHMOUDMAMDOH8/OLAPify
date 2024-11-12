{{
    config(
        materialized='incremental',
        unique_key='supplier_sk',
        indexes=[
            {"columns":['supplier_sk'],'unique':true}
        ],
        group='suppliers'
    )
}}

with valid_suppliers as (
    select
        supplier_id,
        contact_title,
        contact_name,
        company_name,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        homepage,
        'northwind_db' as data_source 
    from{{source('northwind_raw','suppliers')}}
    where
        supplier_id is not null
        and contact_title is not NULL
        and contact_name is not null
        and company_name is not null
        and address is not null
        and city is not null
        and region is not null
        and postal_code is not null
        and country is not null
        and phone is not NULL
        and homepage is not null
)

select
    md5(supplier_id || data_source) as supplier_sk,
    *
from valid_suppliers