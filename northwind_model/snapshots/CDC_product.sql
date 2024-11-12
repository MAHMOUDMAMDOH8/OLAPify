{% snapshot CDC_product %}
{{
    config(
        unique_key='product_id',
        strategy='check',
        check_cols=['unit_price', 'discontinued'],
        target_schema='snapshot'
    )
}}

select 
    product_id::int,
    product_name::varchar(50),
    supplier_id::int,
    category_id::int,
    quantity_per_unit::varchar(20),
    unit_price::real,
    units_in_stock::int,
    units_on_order::int,
    reorder_level::int,
    discontinued::boolean
from {{ source('northwind_raw', 'products') }}
{% endsnapshot %}
