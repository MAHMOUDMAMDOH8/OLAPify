WITH Fact_agg AS (
    SELECT 
        order_date_sk,
        SUM((unit_price * quantity) * (1 - discount)) AS total_sales,
        SUM(quantity) AS total_quantity
    FROM {{ ref("fact_orders") }} -- fact_orders table
    GROUP BY order_date_sk
),
Date_dim AS (
    SELECT 
        date_sk,
        year,
        month
    FROM {{ ref("dim_date") }} -- dim_date table
)

SELECT 
    dd.year,
    dd.month,
    sum(fa.total_sales),
    sum(fa.total_quantity)
FROM Fact_agg fa
LEFT JOIN Date_dim dd
    ON fa.order_date_sk = dd.date_sk
GROUP BY month,year
ORDER BY dd.year, dd.month;
