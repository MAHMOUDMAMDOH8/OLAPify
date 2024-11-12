{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='employee_sk',
        indexes=
        [
            {"columns":['employee_sk'],'unique':true}
        ]
    )
}}

with dim_employee as (
    select 
        employee_sk,
        first_name,
        last_name,
        title,
        birth_date,
        hire_date,
        md5(address || postal_code ) as location_sk,
        home_phone
    from {{ref("stg_employee")}}
)
SELECT * FROM dim_employee