CREATE TRIGGER INSERT_PRODUCT_2
 BEFORE INSERT ON "dev.Magaz::Products"
 REFERENCING NEW ROW new_product
 FOR EACH ROW 

 BEGIN
     DECLARE companies INT;
     
     select count(*) into companies from "DEV"."dev.Magaz::Companies" where "CompanyID" = :new_product."CompanyID";
     
     if companies <> 0 then
         INSERT INTO "DEV"."dev.Magaz::Products" VALUES(:new_product);
     END IF;
 END;