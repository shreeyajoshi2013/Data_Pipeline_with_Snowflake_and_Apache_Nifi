--Create TASKADMIN role using SECURITYADMIN role
USE ROLE SECURITYADMIN;
CREATE OR REPLACE ROLE TASKADMIN;

-- Grantin the EXECUTE TASK privilege to TASKADMIN after setting or using active role to ACCOUNTADMIN 
USE ROLE ACCOUNTADMIN;
GRANT EXECUTE TASK ON ACCOUNT TO ROLE TASKADMIN;

-- Grant TASKADMIN role to SYSADMIN role after setting or using active role to SECURITYADMIN
USE ROLE SECURITYADMIN;
GRANT ROLE TASKADMIN TO ROLE SYSADMIN;


USE ROLE ACCOUNTADMIN;


-- Create Task

CREATE OR REPLACE TASK tsk_scd_raw 
    WAREHOUSE = COMPUTE_WH 
    SCHEDULE = '1 minute'
    ERROR_ON_NONDETERMINISTIC_MERGE=FALSE
    AS
        CALL pdr_scd_demo();


SHOW TASKS;
ALTER TASK tsk_scd_raw SUSPEND;--RESUME; --SUSPEND
SHOW TASKS;


SELECT timestampdiff(second, current_timestamp, scheduled_time) AS next_run
    ,scheduled_time 
    ,current_timestamp
    ,name
    ,state 
FROM TABLE(information_schema.task_history()) 
WHERE state = 'SCHEDULED' 
ORDER BY completed_time DESC;


SELECT * FROM customer WHERE customer_id=0;