{{
    config(
        materialized='incremental',
        strategy='append',
        unique_key='order_id',
        indexes = 
        [
            {"columns": ['order_id'], 'unique': False}, 
            {"columns": ['product_id'], 'unique': False},
        ],
        group="orders"
    ) 
}}



SELECT 
    order_id::int,
    product_id::int, 
    unit_price::numeric, 
    quantity::int, 
    discount::numeric
    , 'northwind_db' AS data_source

FROM
    {{ source('northwind_raw', 'order_details') }}
WHERE
    order_id IS NOT NULL
    AND
    product_id IS NOT NULL
    AND
    unit_price IS NOT NULL
    AND
    quantity IS NOT NULL