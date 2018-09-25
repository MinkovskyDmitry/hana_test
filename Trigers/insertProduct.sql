CREATE TRIGGER "DEV"."InsertProduct"
BEFORE INSERT ON "dev.Magaz.Tables::Products"
REFERENCING NEW ROW new_product
FOR EACH ROW
BEGIN
    DECLARE product INT;
    DECLARE company_ID_not_exist condition for SQL_ERROR_CODE 19999;
    select count(*) into product from "DEV"."dev.Magaz.Tables::Companies" where "CompanyID" = :new_product."CompanyID";
    
    IF (product = 0) THEN
    	signal company_ID_not_exist SET MESSAGE_TEXT = 'Company ID ' || TO_VARCHAR(:new_product."CompanyID") || ' does not exist';
    END IF;

END