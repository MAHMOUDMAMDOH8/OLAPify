{{
    config(
        materialized='incremental',
        strategy='merge',
        unique_key='category_id',
        indexes=[
            {"columns":['category_id'],'unique':true}
        ],
        target_schema='staging_tables'
    )
}}

with category_data as (
    select 
        category_id::int,
        category_name::varchar(50),
        description::varchar(250),
        'northwind_db' as data_source 
    from {{source('northwind_raw','categories')}}
),
clean_category as(
    Select
        *
    from category_data
    where 
        category_id is not null
    and
        category_name is not null
    and 
        description is not null
)

select 
    md5(category_name || data_source) as category_sk,
    *
from clean_category