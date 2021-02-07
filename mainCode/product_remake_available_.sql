-- PREPEI PRWTA NA APENERGOPOIHSOUME TO SAFE MODE TOU WORKBENCH


 UPDATE `Offers`
 SET `Offering_now` = true
 WHERE `Offers`.`Barcode` = '15168';

 UPDATE `Products`
 SET `Is_available` = true
 WHERE `Barcode` = 15168;