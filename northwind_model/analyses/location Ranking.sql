with Fact_agg as (
    select 
        location_sk,
        SUM((unit_price * quantity) * (1 - discount)) AS total_sales,
        sum(quantity)as total_quantity
    from {{ref("fact_orders")}}
    GROUP BY location_sk
),
location_dim as (
    select 
        location_sk,
        country,
        city
    from {{ref("dim_location")}}
)

select
    country,
    city,
    total_sales,
    total_quantity,
    rank()over(PARTITION BY country order by total_sales) as l_rank
from Fact_agg f
LEFT join location_dim l
    on f.location_sk = l.location_sk
