# OLAPify


DISCLAIMER: This project uses northwind as source data, which is a publicly avaiable dataset.

## Project Objectives

This project aims to craft a modern data warehouse solution that:

    Tracks orders by product, cateory and location.
    Tracks product price chaneges using Slowly Chaning Dimension (SCD) type 2.

# Business Logic

    Cutomer names, products name, cateories, location data are consistent a cross all sources.
    It's planned to integrate more ddata sources in the future.

Approach
flowchart LR;
    A[Source 1]
    B[Source 2]
    C[Staging table orders]
    D[Join operation]
    F[Orders fact]
    G[Staging table products]
    Gs[MD5]

    A -- "store 'source 1' in data_src" --> C
    B -- "store 'source 2' in data_src" --> C

    A -- "store 'source 1' in data_src" --> G
    B -- "store 'source 2' in data_src" --> G

    G -- "create surrogate key" --> Gs
    C -- "product_id AND data_src" --> D
    Gs -- "product_id AND data_src" --> D

    D -- "Replace source foreign keys with new products surrogate keys" --> F





