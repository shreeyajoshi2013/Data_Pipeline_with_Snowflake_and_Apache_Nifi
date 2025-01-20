MERGE INTO customer c 
USING customer_raw cr
   ON c.customer_id = cr.customer_id
WHEN MATCHED 
    AND c.customer_id <> cr.customer_id 
    OR c.first_name  <> cr.first_name  
    OR c.last_name   <> cr.last_name   
    OR c.email       <> cr.email
    OR c.street      <> cr.street
    OR c.city        <> cr.city
    OR c.state       <> cr.state
    OR c.country     <> cr.country 
    THEN UPDATE
                SET c.customer_id = cr.customer_id
                    ,c.first_name  = cr.first_name 
                    ,c.last_name   = cr.last_name  
                    ,c.email       = cr.email      
                    ,c.street      = cr.street     
                    ,c.city        = cr.city       
                    ,c.state       = cr.state      
                    ,c.country     = cr.country  
                    ,update_timestamp = current_timestamp()
WHEN NOT MATCHED 
    THEN INSERT 
                (c.customer_id,c.first_name,c.last_name,c.email,c.street,c.city,c.state,c.country)
                VALUES (cr.customer_id,cr.first_name,cr.last_name,cr.email,cr.street,cr.city,cr.state,cr.country);


    
    
SELECT * FROM customer_raw LIMIT 10;
SELECT COUNT(*) FROM customer_raw; 
SELECT * FROM customer LIMIT 10;
SELECT COUNT(*) FROM customer;
-- TRUNCATE customer;



CREATE OR REPLACE PROCEDURE pdr_scd_demo()
RETURNS STRING NOT NULL
LANGUAGE JAVASCRIPT
AS
    $$
      var cmd = `
            MERGE INTO customer c 
            USING customer_raw cr
               ON c.customer_id = cr.customer_id
            WHEN MATCHED 
                AND c.customer_id <> cr.customer_id 
                OR c.first_name  <> cr.first_name  
                OR c.last_name   <> cr.last_name   
                OR c.email       <> cr.email
                OR c.street      <> cr.street
                OR c.city        <> cr.city
                OR c.state       <> cr.state
                OR c.country     <> cr.country 
                THEN UPDATE
                        SET c.customer_id = cr.customer_id
                            ,c.first_name  = cr.first_name 
                            ,c.last_name   = cr.last_name  
                            ,c.email       = cr.email      
                            ,c.street      = cr.street     
                            ,c.city        = cr.city       
                            ,c.state       = cr.state      
                            ,c.country     = cr.country  
                            ,update_timestamp = current_timestamp()
            WHEN NOT MATCHED 
                THEN INSERT 
                            (c.customer_id,c.first_name,c.last_name,c.email,c.street,c.city,c.state,c.country)
                            VALUES (cr.customer_id,cr.first_name,cr.last_name,cr.email,cr.street,cr.city,cr.state,cr.country);
                            `
      var cmd1 = "TRUNCATE TABLE SCD_DEMO.SCD2.customer_raw;"
      var sql = snowflake.createStatement({sqlText: cmd});
      var sql1 = snowflake.createStatement({sqlText: cmd1});
      var result = sql.execute();
      var result1 = sql1.execute();
    return cmd+'\n'+cmd1;
    $$;

CALL pdr_scd_demo();


SELECT COUNT(*) from customer_raw;
SELECT COUNT(*) from customer;