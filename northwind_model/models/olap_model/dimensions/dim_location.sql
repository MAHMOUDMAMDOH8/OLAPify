{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='location_sk',
        indexes = [
            {"columns": ['location_sk'], 'unique': true}
        ]
    )
}}

{% set not_null_cols = [
    'address', 'city', 'postal_code'
] %}

with customer_location as (
    select
        DISTINCT address,
        city,
        region,
        postal_code,
        country
    from {{ref("stg_customer")}}
),
employee_location as (
    select
        DISTINCT address,
        city,
        region,
        postal_code,
        country
    from {{ref('stg_employee')}}
),
supplier_location as(
    select
        DISTINCT address,
        city,
        region,
        postal_code,
        country
    from {{ref("stg_suppliers")}}
),
order_location as(
    SELECT  
        DISTINCT ship_address AS address,
        ship_city AS city,
        ship_region AS region,
        ship_postal_code AS postal_code,
        ship_country AS country
    FROM {{ ref("stg_orders") }}
),
location_dim as (
    select * from order_location
    union 
    select * from supplier_location
    union 
    select * from employee_location
    union
    select * from customer_location
)

select 
    distinct md5(address || postal_code) as location_sk,
    address,
    city,
    region,
    postal_code,
    country
from location_dim
WHERE address is not null 
    and postal_code is not null