CREATE TRIGGER "DEV"."InsertDetail"
BEFORE INSERT ON "dev.Magaz.Tables::OrderDetails"
REFERENCING NEW ROW new_order_det
FOR EACH ROW
BEGIN
    DECLARE product INT;
    DECLARE product_ID_not_exist condition for SQL_ERROR_CODE 19999;
    select count(*) into product from "DEV"."dev.Magaz.Tables::Products" where "ProductID" = :new_order_det."ProductID";
    
    IF (product = 0) THEN
    	signal product_ID_not_exist SET MESSAGE_TEXT = 'Product ID ' || TO_VARCHAR(:new_order_det."ProductID") || ' does not exist';
    END IF;

END

