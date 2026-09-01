-- ==========================================================
-- AIRBNB RAW DATA INGESTION (SNOWFLAKE SETUP)
-- ==========================================================

-- 1. Set up Warehouse, Database & Schemas
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
USE WAREHOUSE COMPUTE_WH;

CREATE DATABASE IF NOT EXISTS AIRBNB;
CREATE SCHEMA IF NOT EXISTS AIRBNB.RAW;
CREATE SCHEMA IF NOT EXISTS AIRBNB.DEV;

USE DATABASE AIRBNB;
USE SCHEMA RAW;

-- 2. Raw Listings Table
CREATE OR REPLACE TABLE raw_listings (
    id INTEGER,
    listing_url STRING,
    name STRING,
    room_type STRING,
    minimum_nights INTEGER,
    host_id INTEGER,
    price STRING,
    created_at DATETIME,
    updated_at DATETIME
);

COPY INTO raw_listings (
    id,
    listing_url,
    name,
    room_type,
    minimum_nights,
    host_id,
    price,
    created_at,
    updated_at
)
FROM 's3://dbt-datasets/listings.csv'
FILE_FORMAT = (
    TYPE = 'CSV' 
    SKIP_HEADER = 1 
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);

-- 3. Raw Reviews Table
CREATE OR REPLACE TABLE raw_reviews (
    listing_id INTEGER,
    date DATETIME,
    reviewer_name STRING,
    comments STRING,
    sentiment STRING
);

COPY INTO raw_reviews (
    listing_id, 
    date, 
    reviewer_name, 
    comments, 
    sentiment
)
FROM 's3://dbt-datasets/reviews.csv'
FILE_FORMAT = (
    TYPE = 'CSV' 
    SKIP_HEADER = 1 
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);

-- 4. Raw Hosts Table
CREATE OR REPLACE TABLE raw_hosts (
    id INTEGER,
    name STRING,
    is_superhost STRING,
    created_at DATETIME,
    updated_at DATETIME
);

COPY INTO raw_hosts (
    id, 
    name, 
    is_superhost, 
    created_at, 
    updated_at
)
FROM 's3://dbt-datasets/hosts.csv'
FILE_FORMAT = (
    TYPE = 'CSV' 
    SKIP_HEADER = 1 
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);
