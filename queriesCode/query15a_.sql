SELECT 
100*(SELECT COUNT( distinct `Customer`.`Card#`) 
 FROM `Customer`
 WHERE `Is_member` = false ) 
    /
(SELECT COUNT( distinct `Customer`.`Card#`) 
 FROM `Customer` ) as `Pososto`