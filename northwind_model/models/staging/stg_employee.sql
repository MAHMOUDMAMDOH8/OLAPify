{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='employee_sk',
        indexes=[
            {"columns": ['employee_sk'], 'unique': true}
        ],
        target_schema='staging_tables'
    )
}}

with valid_employee as (
    select
        employee_id,
        first_name,
        last_name,
        title,
        birth_date,
        hire_date,
        address,
        city,
        region,
        postal_code,
        country,
        home_phone,
        'northwind_db' as data_source 
    from {{ source('northwind_raw', 'employees') }} as e
    where
        employee_id is not null
        and first_name is not null
        and last_name is not null
        and title is not null
        and address is not null
        and postal_code is not null
        and hire_date is not null
)

select 
    md5(employee_id || data_source) as employee_sk,
    *
from valid_employee
