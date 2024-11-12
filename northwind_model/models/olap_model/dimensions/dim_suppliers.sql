{{ 
    config(
        materialized='incremental',
        unique_key='supplier_sk',
        indexes=[{"columns": ['supplier_sk'], 'unique': True}],
        group="suppliers"
    ) 
}}

WITH suppliers_data AS (
    SELECT
        supplier_sk, 
        supplier_id,
        company_name,
        contact_name,
        contact_title,
        homepage,
        md5(address || postal_code ) as location_sk
    FROM 
        {{ref("stg_suppliers")}}
)
SELECT * from suppliers_data