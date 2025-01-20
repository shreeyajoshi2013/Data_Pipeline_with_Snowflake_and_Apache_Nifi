CREATE DATABASE IF NOT EXISTS scd_demo;
USE DATABASE scd_demo;

CREATE SCHEMA IF NOT EXISTS scd2;
USE SCHEMA scd2;

SHOW TABLES;


CREATE OR REPLACE TABLE customer_raw (
     customer_id NUMBER,
     first_name VARCHAR,
     last_name VARCHAR,
     email VARCHAR,
     street VARCHAR,
     city VARCHAR,
     state VARCHAR,
     country VARCHAR);


CREATE OR REPLACE TABLE customer (
     customer_id NUMBER,
     first_name VARCHAR,
     last_name VARCHAR,
     email VARCHAR,
     street VARCHAR,
     city VARCHAR,
     state VARCHAR,
     country VARCHAR,
     update_timestamp timestamp_ntz DEFAULT current_timestamp());

-- CREATE OR REPLACE TABLE customer_history (
--      customer_id NUMBER,
--      first_name VARCHAR,
--      last_name VARCHAR,
--      email VARCHAR,
--      street VARCHAR,
--      city VARCHAR,
--      state VARCHAR,
--      country VARCHAR,
--      start_time timestamp_ntz DEFAULT current_timestamp(),
--      end_time timestamp_ntz DEFAULT current_timestamp(),
--      is_current BOOLEAN
--      );
     

-- CREATE OR REPLACE STREAM customer_table_changes ON TABLE customer;