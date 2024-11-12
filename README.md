# OLAPify


The Mermaid Whiteboard is now available in our editor!
Mermaid Chart Logo

    Projects
    ›
    Personal
    ›
    Untitled diagram

User avatar
user-icon Create an ER diagram for an entity relationship model
Mermaid Chart Logo
user-icon ```mermaid erDiagram DIM_CUSTOMERS { string customer_sk string contact_name string contact_title string company_name string location_sk } DIM_DATE { string date_sk date full_date int year int month int day string day_name } DIM_EMPLOYEE { string employee_sk string first_name string last_name string title date birth_date date hire_date string location_sk string home_phone } DIM_LOCATION { string location_sk string address string city string region string postal_code string country } DIM_PRODUCTS { string product_sk string product_name string category_sk string category_name float unit_price string quantity_per_unit boolean discontinued } DIM_SUPPLIERS { string supplier_sk int supplier_id string company_name string contact_name string contact_title string homepage string location_sk } FACT_ORDERS { string transaction_id int order_id string customer_sk string employee_sk string order_date_sk string ship_date_sk string product_sk string location_sk numeric unit_price int quantity numeric discount int ship_via numeric freight string ship_name } DIM_CUSTOMERS ||--o| DIM_LOCATION : has_location DIM_EMPLOYEE ||--o| DIM_LOCATION : has_location FACT_ORDERS ||--o| DIM_CUSTOMERS : places FACT_ORDERS ||--o| DIM_EMPLOYEE : handled_by FACT_ORDERS ||--o| DIM_DATE : ordered_on FACT_ORDERS ||--o| DIM_DATE : shipped_on FACT_ORDERS ||--o| DIM_PRODUCTS : includes FACT_ORDERS ||--o| DIM_LOCATION : ships_from
Mermaid Chart Logo
user-icon erDiagram DIM_CUSTOMERS { string customer_sk string contact_name string contact_title string company_name string location_sk } DIM_DATE { string date_sk date full_date int year int month int day string day_name } DIM_EMPLOYEE { string employee_sk string first_name string last_name string title date birth_date date hire_date string location_sk string home_phone } DIM_LOCATION { string location_sk string address string city string region string postal_code string country } DIM_PRODUCTS { string product_sk string product_name string category_sk string category_name float unit_price string quantity_per_unit boolean discontinued } DIM_SUPPLIERS { string supplier_sk int supplier_id string company_name string contact_name string contact_title string homepage string location_sk } FACT_ORDERS { string transaction_id int order_id string customer_sk string employee_sk string order_date_sk string ship_date_sk string product_sk string location_sk numeric unit_price int quantity numeric discount int ship_via numeric freight string ship_name } DIM_CUSTOMERS ||--o| DIM_LOCATION : has_location DIM_EMPLOYEE ||--o| DIM_LOCATION : has_location FACT_ORDERS ||--o| DIM_CUSTOMERS : places FACT_ORDERS ||--o| DIM_EMPLOYEE : handled_by FACT_ORDERS ||--o| DIM_DATE : ordered_on FACT_ORDERS ||--o| DIM_DATE : shipped_on FACT_ORDERS ||--o| DIM_PRODUCTS : includes FACT_ORDERS ||--o| DIM_LOCATION : ships_from
Mermaid Chart Logo
user-icon return markdown for the erd
Mermaid Chart Logo

Certainly! Here's the markdown representation of your ER diagram in Mermaid syntax. You can use this in any markdown editor that supports Mermaid rendering to visualize your ER diagram.

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

    DIM_CUSTOMERS ||--o| DIM_LOCATION : "has location"
    DIM_EMPLOYEE ||--o| DIM_LOCATION : "uses location"
    FACT_ORDERS ||--o| DIM_CUSTOMERS : "placed by"
    FACT_ORDERS ||--o| DIM_EMPLOYEE : "handled by"
    FACT_ORDERS ||--o| DIM_DATE : "ordered on"
    FACT_ORDERS ||--o| DIM_DATE : "shipped on"
    FACT_ORDERS ||--o| DIM_PRODUCTS : "includes"
    FACT_ORDERS ||--o| DIM_LOCATION : "ships from"


### Usage:
- **Markdown Editors**: This code can be rendered in any markdown editor that has support for Mermaid, such as Typora or tools like Obsidian.
- **Web Renderers**: Websites or applications like GitHub (with Mermaid enabled) or dedicated Mermaid live editors can also render this markdown to visualize your ER diagram.

When you paste the markdown into an appropriate editor or platform, it will produce the entity-relationship diagram you have defined here.

Upgrade to Pro for unlimited chat messages.
Editor | Mermaid Chart
