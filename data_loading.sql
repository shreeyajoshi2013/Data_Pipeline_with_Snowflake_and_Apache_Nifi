CREATE OR REPLACE STAGE SCD_DEMO.SCD2.customer_ext_stage
    url='s3://sj-snowflake-project-bucket-001/stream_data/'
    credentials=(aws_key_id='<aws_key_id>' 
                 aws_secret_key='<aws_secret_key>');
   
CREATE OR REPLACE FILE FORMAT SCD_DEMO.SCD2.CSV
TYPE = CSV,
FIELD_DELIMITER = ","
SKIP_HEADER = 1;



SHOW STAGES;
LIST @customer_ext_stage;


CREATE OR REPLACE PIPE customer_s3_pipe
  auto_ingest = true
  AS
  COPY INTO customer_raw
  FROM @customer_ext_stage
  FILE_FORMAT = CSV;

  
SELECT * FROM CUSTOMER_RAW; 
SELECT COUNT(*) from customer_raw;

  
SHOW PIPES;
SELECT SYSTEM$PIPE_STATUS('customer_s3_pipe');


-- TRUNCATE  customer_raw;