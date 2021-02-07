DROP TRIGGER IF EXISTS `Older_prices_make`

DELIMITER $$

CREATE TRIGGER `Older_prices_make` after INSERT ON `Products`
FOR EACH ROW BEGIN
    if (
        (( select `Products`.`Is_available`
           from `Products`
           where NEW.`Barcode` = `Products`.`Barcode`)
          in
           (0)
        )
        and
        (  1
          not in
           (select `Offers`.`Offering_now`
           from `Offers`
           where NEW.`Barcode` = `Offers`.`Barcode`)
        ) )
    then SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
        SET MESSAGE_TEXT = 'This product is not available, you cannot change its price';
    else 
        UPDATE `Older_Prices`
        SET `Older_Prices`.`End_date` = CURDATE()
        WHERE NEW.`Barcode` = `Older_Prices`.`P_Barcode`
        and `Older_Prices`.`End_date` = '2099-12-30';
        INSERT INTO `Older_Prices` VALUES(now(), NEW.`Price`, '2099-12-30', NEW.`Barcode`);
    end if;
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS `Older_prices_after_update`

DELIMITER $$

CREATE TRIGGER `Older_prices_after_update` before UPDATE ON `Products`
FOR EACH ROW BEGIN
    if (
        (( select `Products`.`Is_available`
        from `Products`
        where NEW.`Barcode` = `Products`.`Barcode`)
        in
        (0)
        )
        and
        (
        0
        in
        (select `Offers`.`Offering_now`
        from `Offers`
        where NEW.`Barcode` = `Offers`.`Barcode`)
        ) )
    then SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
        SET MESSAGE_TEXT = 'This product is not available, you cannot change its price';
    else 
        UPDATE `Older_Prices`
        SET `Older_Prices`.`End_date` = CURDATE()
        WHERE NEW.`Barcode` = `Older_Prices`.`P_Barcode`
        and `Older_Prices`.`End_date` = '2099-12-30';
        INSERT `Older_Prices` VALUES(now(), NEW.`Price`, '2099-12-30', NEW.`Barcode`);
    end if;
END$$

DELIMITER ;


DROP TRIGGER IF EXISTS Transaction_check;

DELIMITER $$

CREATE TRIGGER Transaction_check BEFORE INSERT ON `Transaction`
FOR EACH ROW BEGIN
	IF 
		
		((SELECT `Operates`
		FROM `Stores`
        WHERE `Stores`.`Store_id` = NEW.`Store_id`)
        IN (0))
        OR
        ((SELECT `Is_member`
         FROM `Customer`
         WHERE `Customer`.`Card#` = NEW.`Card#`)
         IN (0))
	THEN 	SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
			SET MESSAGE_TEXT = 'The store is not operating anymore or the card# is deactivated!';  
    END IF;
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS Offers_check;

DELIMITER $$

CREATE TRIGGER Offers_check BEFORE INSERT ON `offers`
FOR EACH ROW BEGIN
	IF 
		(SELECT `Category_id`
		FROM `Products`
		WHERE NEW.`Barcode` = `Products`.`Barcode`)
		not in
		(SELECT `Category_id` 
		FROM `Provides`
		WHERE NEW.`Store_id` = `Provides`.`Store_id`)
	THEN 	SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
			SET MESSAGE_TEXT = 'Products from this category are not available here!';      
    END IF;
END$$

DELIMITER ;


DROP TRIGGER IF EXISTS Contains_check;

DELIMITER $$

CREATE TRIGGER Contains_check BEFORE INSERT ON my_project.`Contains`
FOR EACH ROW BEGIN
	IF 
		((SELECT `Store_id`
		FROM `Transaction`
		WHERE NEW.`Card#` = `Transaction`.`Card#`
         and  NEW.`DateTime` = `Transaction`.`DateTime`)
		not in
		(SELECT `Store_id` 
		FROM `Offers`
		WHERE NEW.`Barcode` = `Offers`.`Barcode`))
        OR
        ((SELECT `Offers`.`Offering_now`
        FROM `Offers`, `Transaction`
        WHERE NEW.`Barcode` = `Offers`.`Barcode`
        and NEW.`Card#` = `Transaction`.`Card#`
		and  NEW.`DateTime` = `Transaction`.`DateTime`
        and `Transaction`.`Store_id` = `Offers`.`Store_id`)
        in (0))

	THEN 	SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
			SET MESSAGE_TEXT = 'This product is not available here! You can not buy it!!';            
    END IF;
END$$

DEMILITER ;

DROP TRIGGER IF EXISTS Trans_Total_pieces;

DELIMITER $$

CREATE TRIGGER Trans_Total_pieces AFTER INSERT ON `Contains`
FOR EACH ROW BEGIN
UPDATE `Transaction` SET `Transaction`.`Total_pieces` = `Transaction`.`Total_pieces` +	NEW.`Pieces`
WHERE `Transaction`.`DateTime` = NEW.`DateTime`
		and `Transaction`.`Card#` = NEW.`Card#`;
END$$


DELIMITER ;


DROP TRIGGER IF EXISTS Trans_Total_amount;

DELIMITER $$

CREATE TRIGGER Trans_Total_amount AFTER INSERT ON `Contains`
FOR EACH ROW BEGIN

		UPDATE `Transaction` 
        SET `Transaction`.`Total_amount` = `Transaction`.`Total_amount` +	NEW.`Pieces` *
											(	SELECT `O_Price`
												FROM `Older_prices`
												WHERE NEW.`Barcode` = `Older_prices`.`P_Barcode`
												and	 (  NEW.`DateTime` BETWEEN 
																DATE(`Older_prices`.`Start_date`) AND   `Older_prices`.`End_date` ) )
		WHERE NEW.`DateTime`=`Transaction`.`DateTime`
		and NEW.`Card#`=`Transaction`.`Card#`;
END$$

DELIMITER ;