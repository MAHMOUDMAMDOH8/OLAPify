WITH Fact_agg AS (
    SELECT 
        product_sk,
        SUM((unit_price * quantity) * (1 - discount)) AS total_sales,
        SUM(quantity) AS total_quantity
    FROM {{ ref("fact_orders") }} -- fact_orders table
    GROUP BY product_sk
),
Product_dim AS (
    SELECT 
        product_sk,
        product_name,
        category_name
    FROM {{ ref("dim_products") }} -- dim_products table
)

SELECT 
    pd.product_name,
    pd.category_name,
    fa.total_sales,
    fa.total_quantity,
    RANK() OVER (PARTITION BY pd.category_name ORDER BY fa.total_sales DESC) AS p_rank
FROM Fact_agg fa
LEFT JOIN Product_dim pd
    ON fa.product_sk = pd.product_sk
ORDER BY pd.category_name, p_rank;
