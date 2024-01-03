-- How many staff are there in all the UK stores 
SELECT DISTINCT country_code FROM dim_store; -- To determine country code for UK 

SELECT SUM(staff_numbers) 
FROM 
     dim_store 
WHERE 
     country_code IN ('GB');
