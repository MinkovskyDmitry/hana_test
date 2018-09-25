CREATE TRIGGER "DEV"."InsertOrder"
BEFORE INSERT ON "dev.Magaz.Tables::Orders"
REFERENCING NEW ROW new_order
FOR EACH ROW
BEGIN
    DECLARE count_records INT;
    
    DECLARE employee_ID_not_exist condition for SQL_ERROR_CODE 19999;
    DECLARE shop_ID_not_exist condition for SQL_ERROR_CODE 19999;
    
    select count(*) into count_records from "DEV"."dev.Magaz.Tables::Employee"" where "EmployeeID" = :new_order."EmployeeID";
    
    IF (count_records = 0) THEN
    	signal employee_ID_not_exist SET MESSAGE_TEXT = 'Employee ID ' || TO_VARCHAR(:new_order."EmployeeID") || ' does not exist';
    END IF;
    
    select count(*) into count_records from "DEV"."dev.Magaz.Tables::Shops" where "ShopID" = :new_order."ShopID";
    
    IF (count_records = 0) THEN
    	signal shop_ID_not_exist SET MESSAGE_TEXT = 'Shop ID ' || TO_VARCHAR(:new_order."ShopID") || ' does not exist';
    END IF;

END