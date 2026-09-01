# Raw Airbnb Datasets & Source Information

This directory contains reference information, S3 bucket source URLs, and Snowflake data ingestion scripts for the raw Airbnb dataset used in this project.

## S3 Source Data URLs

The raw CSV files are stored and publicly accessible in the following Amazon S3 buckets:

| Table | Source File URL | S3 URI | Description |
| :--- | :--- | :--- | :--- |
| **`raw_listings`** | [listings.csv](https://dbt-datasets.s3.amazonaws.com/listings.csv) | `s3://dbt-datasets/listings.csv` | Airbnb listing details (prices, room types, minimum nights, host info). |
| **`raw_reviews`** | [reviews.csv](https://dbt-datasets.s3.amazonaws.com/reviews.csv) | `s3://dbt-datasets/reviews.csv` | Review data including comments, review dates, and sentiment. |
| **`raw_hosts`** | [hosts.csv](https://dbt-datasets.s3.amazonaws.com/hosts.csv) | `s3://dbt-datasets/hosts.csv` | Host profiles and superhost status. |

---

## Snowflake Ingestion Architecture

In production and ELT architectures, raw files are loaded directly from cloud storage into the data warehouse using Snowflake's native `COPY INTO` command without storing large CSV dumps directly in the Git repository.

To replicate or set up the raw tables in Snowflake from scratch, see the SQL script:
- [`snowflake_setup.sql`](./snowflake_setup.sql)
