-- PREPEI PRWTA NA APENERGOPOIHSOUME TO SAFE MODE TOU WORKBENCH


-- WHENEVER WE DELETE A PRODUCT WITH BARCODE = 14816 FOR EXAMPLE, there's a flag attribute called `Is_available` (default value = true)
-- that is set to false and the product is deleted from the offers table
-- as a result, we cannot buy the product until is becomes available again
-- TO GO BACK TO AVAILABLE: USER NEEDS TO UPDATE THE FLAG'S VALUE BACK TO TRUE

 
 
 UPDATE `Products`
 SET `Is_available` = false
 WHERE `Products`.`Barcode` = 15168;

 UPDATE `Offers`
 SET `Offering_now` = false
 WHERE `Offers`.`Barcode` = '15168';
 
 -- TEST:
-- INSERT `Contains` VALUES ("2020-06-11 19:20:33", 4	, 15168, 2);