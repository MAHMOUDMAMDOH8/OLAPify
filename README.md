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
    A[Source 1] --> C[Staging table orders]
    A --> G[Staging table products]
    B[Source 2] --> C
    B --> G
    C --> D[Join operation]
    G --> Gs[MD5]
    Gs --> D
    D --> F[Orders fact]

    A:::data_src
    B:::data_src
    C:::staging
    G:::staging
    Gs:::transformation
    D:::transformation
    F:::fact

    classDef data_src fill:#f9f,stroke:#333,stroke-width:2px;
    classDef staging fill:#ccf,stroke:#333,stroke-width:2px;
    classDef transformation fill:#fcf,stroke:#333,stroke-width:2px;
    classDef fact fill:#cfc,stroke:#333,stroke-width:2px;
    
    %% Apply background color to the whole diagram
    style A, B, C, D, G, Gs, F fill:#333,stroke:#fff,stroke-width:1px;
    style A, B fill:#333;
    style C, G fill:#222;
    style D, Gs, F fill:#111;
