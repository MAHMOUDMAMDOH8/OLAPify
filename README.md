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
flowchart LR
    A[Source 1] -->| "store 'source 1' in data_src" | C[Staging table orders]
    B[Source 2] -->| "store 'source 2' in data_src" | C
    A -->| "store 'source 1' in data_src" | G[Staging table products]
    B -->| "store 'source 2' in data_src" | G
    G -->| "create surrogate key" | Gs[MD5]
    C -->| "product_id AND data_src" | D[Join operation]
    Gs -->| "product_id AND data_src" | D
    D -->| "Replace source foreign keys with new product surrogate keys" | F[Orders fact]
