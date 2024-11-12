{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='customer_sk',
        indexes=
        [
            {"columns":['customer_sk'],'unique':true}
        ]
    )
}}

with customer_dim as (
    select 
        customer_sk,
        contact_name,
        contact_title,
        company_name,
        md5(address || postal_code ) as location_sk
    from {{ref("stg_customer")}}
)

select * from customer_dim