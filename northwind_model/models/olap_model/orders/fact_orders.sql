{{
    config(
        materialized='incremental',
        strategy='merge',
        unique_key='transaction_id',
        indexes = 
        [
            {"columns": ['transaction_id'], 'unique': True},
            {"columns": ['location_sk'], 'unique': False},
            {"columns": ['product_sk'], 'unique': False},
            {"columns": ['employee_sk'], 'unique': False},
            {"columns": ['customer_sk'], 'unique': False},
            {"columns": ['order_date_sk'], 'unique': False},
            {"columns": ['ship_date_sk'], 'unique': False}
        ]
    ) 
}}

with orders as (
    SELECT
        o.order_id, 
        c.customer_sk, 
        e.employee_sk, 
        od.date_sk as order_date_sk, 
        sd.date_sk as ship_date_sk,
        o.ship_via, 
        o.freight, 
        o.ship_name,
        o.data_source,
        dl.location_sk
    FROM {{ref('stg_orders')}} o  
    LEFT JOIN {{ref('stg_customer')}} c 
        ON o.customer_id = c.customer_id
    LEFT JOIN {{ref('stg_employee')}} e 
        ON o.employee_id = e.employee_id
    LEFT JOIN {{ref('dim_date')}} od 
        ON o.order_date = od.full_date  -- Join  order date
    LEFT JOIN {{ref('dim_date')}} sd 
        ON o.shipped_date = sd.full_date  -- Join  ship date
    left join {{ref("dim_location")}} dl -- join location DATETIME
        on o.location_sk = dl.location_sk
),
order_details as (
    SELECT
        od.order_id,
        p.product_sk, 
        od.unit_price, 
        od.quantity, 
        od.discount,
        od.data_source
    FROM {{ref('stg_order_details')}} od  -- Order details table
    LEFT JOIN {{ref('stg_product')}} p 
        ON od.product_id = p.product_id  -- Join  product_sk
),
fact_table as (
    SELECT
        md5(o.order_id || od.product_sk || o.data_source) as transaction_id, -- Generate transaction_id
        o.order_id,
        o.customer_sk,
        o.employee_sk,
        o.order_date_sk,
        o.ship_date_sk,
        od.product_sk,
        o.location_sk,
        od.unit_price,
        od.quantity,
        od.discount,
        o.ship_via,
        o.freight,
        o.ship_name
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
        AND o.data_source = od.data_source
)

SELECT * FROM fact_table

