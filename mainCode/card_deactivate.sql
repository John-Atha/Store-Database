-- WHENEVER WE DELETE A CUSTOMER WITH CARD# = 1 FOR EXAMPLE, there's a flag attribute called `Is_member` (default value = true)
-- that is set to false
-- we can update the customer's information, such as name, address etc 
-- but we cannot insert a new transaction (or anything in the contains table as a result) using this card#
-- we use a trigger gor these two operations
-- TO GO BACK TO BEING A MEMBER: USER NEEDS TO UPDATE THE FLAG'S VALUE BACK TO TRUE

  UPDATE  `Customer`
  SET `Is_member` = false
  WHERE `Customer`.`Card#` = 1

-- TEST:
-- INSERT INTO `Transaction` VALUES ("2010-11-08 07:10:37","Cash",0,1,1,0);