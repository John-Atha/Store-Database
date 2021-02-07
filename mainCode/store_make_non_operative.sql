-- WHENEVER WE DELETE A STORE WITH STORE_ID = 1 FOR EXAMPLE, there's a flag attribute called `operates` (default value = true)
-- that is set to false
-- we can update the list of the products that the store OFFERS and the list of the categories that the store PROVIDES
-- BUT we cannotmake a transaction at this store
-- as a result we create a trigger that chekcs the OPERATE flag for each store that a tnew transaction is made at
-- TO GO BACK TO OPERATING: USER NEEDS TO UPDATE THE FLAG'S VALUE BACK TO TRUE

 UPDATE `Stores`
 SET `Operates` = false
 WHERE `Store_id` = 1;

-- TEST:                                                            |
--                                                                  ^
-- INSERT INTO `Transaction` VALUES ("2010-10-08 07:10:37","Cash",0,1,1,0);