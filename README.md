# OLAPify

**DISCLAIMER:** This project uses the Northwind dataset as the source data, which is a publicly available dataset.

## Project Objectives

This project aims to craft a modern data warehouse solution that:

- Tracks orders by product, category, and location.
- Tracks product price changes using Slowly Changing Dimension (SCD) type 2.

## Business Logic

- Customer names, product names, categories, and location data are consistent across all sources.
- It is planned to integrate more data sources in the future.

## Approach

```mermaid
flowchart LR;
A[Source 1]
B[Source 2]
C[Staing table orders]
D[Join operation]
F[Orders fact]
G[Staging table products]

A -- "store 'source 1' in data_src" --> C
B -- "store 'source 2' in data_src" --> C

A -- "store 'source 1' in data_src" --> G
B -- "store 'source 2' in data_src" --> G

G -- "create surrogate key" --> Gs[MD5]


C -- "product_id AND data_src" --> D
Gs -- "product_id AND data_src" --> D


D --"Replace source foreign keys with new pproducts surrogate keys"--> F;

```


    Adding addition column in all staing tables called data_src to store source's name
    Assuming that cutomer name, product name, cateorie, location data doesn't cause conflicts, it's used as Surrogate key to replace source's foreign keys. Surrogate key can combine one or more concatenated and catsted as text columns using MD5 hashing.
    Source's foreign key and data_src are used as composite key to replace source's foreign key with new surrogate key..
    If possible, the below logic can be used to generate surrogate keys instead of joining.

## Surrogate Keys Logic

| Surrogate Key   | Logic                                        |
|-----------------|----------------------------------------------|
| `product_sk`     | MD5 Hash of cleaned `product_name`          |
| `supplier_sk`   | MD5 Hash of cleaned `supplier_name`          |
| `employee_sk`   | MD5 Hash of cleaned `employee_name`          |
| `data_sk`       | MD5 Hash of cleaned `date` (from `dim_date`) |
| `location_sk`   | MD5 Hash of cleaned `address|| postalcode`   |

## Data Lineage
![Screenshot from 2024-11-12 11-05-55](https://github.com/user-attachments/assets/84ca0f03-63ba-4ea3-9261-18d1899e2aa5)

![Screenshot from 2024-11-12 13-15-07](https://github.com/user-attachments/assets/8b9df5ed-1005-4562-8589-2d15a16f202b)

## ERD

```mermaid
erDiagram
    DIM_CUSTOMERS {
        string customer_sk
        string contact_name
        string contact_title
        string company_name
        string location_sk
    }
    DIM_DATE {
        string date_sk
        date full_date
        int year
        int month
        int day
        string day_name
    }
    DIM_EMPLOYEE {
        string employee_sk
        string first_name
        string last_name
        string title
        date birth_date
        date hire_date
        string location_sk
        string home_phone
    }
    DIM_LOCATION {
        string location_sk
        string address
        string city
        string region
        string postal_code
        string country
    }
    DIM_PRODUCTS {
        string product_sk
        string product_name
        string category_sk
        string category_name
        float unit_price
        string quantity_per_unit
        boolean discontinued
    }
    DIM_SUPPLIERS {
        string supplier_sk
        int supplier_id
        string company_name
        string contact_name
        string contact_title
        string homepage
        string location_sk
    }
    FACT_ORDERS {
        string transaction_id
        int order_id
        string customer_sk
        string employee_sk
        string order_date_sk
        string ship_date_sk
        string product_sk
        string location_sk
        numeric unit_price
        int quantity
        numeric discount
        int ship_via
        numeric freight
        string ship_name
    }

    FACT_ORDERS ||--o| DIM_CUSTOMERS : places
    FACT_ORDERS ||--o| DIM_EMPLOYEE : handled_by
    FACT_ORDERS ||--o| DIM_DATE : ordered_on
    FACT_ORDERS ||--o| DIM_DATE : shipped_on
    FACT_ORDERS ||--o| DIM_PRODUCTS : includes
    FACT_ORDERS ||--o| DIM_LOCATION : ships_from
    FACT_ORDERS ||--o| DIM_SUPPLIERS: handled_by


```


## dbt Model Structure
``` bash
> tree ./northwind_model/models 
./
├── group.yml
├── olap_model
│   ├── dimensions
│   │   ├── dim_customers.sql
│   │   ├── dim_date.sql
│   │   ├── dim_employee.sql
│   │   ├── dimension.yml
│   │   ├── dim_location.sql
│   │   ├── dim_products.sql
│   │   └── dim_suppliers.sql
│   └── orders
│       ├── fact_orders.sql
│       └── orders.yml
├── source.yml
└── staging
    ├── staging.yml
    ├── stg_category.sql
    ├── stg_customer.sql
    ├── stg_employee.sql
    ├── stg_order_details.sql
    ├── stg_orders.sql
    ├── stg_product.sql
    └── stg_suppliers.sql


5 directories, 18 files


