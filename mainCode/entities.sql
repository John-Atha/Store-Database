DROP DATABASE IF EXISTS my_project;
CREATE DATABASE my_project;
USE my_project;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE IF NOT EXISTS `Stores` (
  `Store_id` INT UNSIGNED NOT NULL, 
  `Opening_time` TIME NULL,
  `Closing_time` TIME NULL,	
  `Size` INT UNSIGNED NULL,
  `Store_Street` VARCHAR(45) NULL,
  `Store_Number` INT UNSIGNED NULL,
  `Store_Postal_code` VARCHAR(45) NULL,
  `Store_City` VARCHAR(45) NULL,
  `Operates` BOOLEAN DEFAULT True,
  PRIMARY KEY (`Store_id`),
  CHECK (`Store_id` BETWEEN 1 AND 10) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

CREATE INDEX Store_id_idx ON `Stores`(`Store_id`);
CREATE INDEX Operates_idx ON `Stores`(`Operates`);

CREATE TABLE IF NOT EXISTS `Store_phone#` (
  `S_Phone#` VARCHAR(45) NOT NULL,
  `Store_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`S_Phone#`, `Store_id`),
  FOREIGN KEY (`Store_id`) REFERENCES `Stores` (`Store_id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;
    
    
    
CREATE TABLE IF NOT EXISTS `Category` (
  `Category_id` INT UNSIGNED NOT NULL,
  `Cat_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Category_id`),
  CHECK (`Category_id` BETWEEN 1 AND 6),
  CHECK (`Cat_Name` in ('Fresh products', 'Refrigerator items', 'Cellar products', 'Personal care items', 'Household items', 'Pet products') ) )
  
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;
INSERT INTO `Category` VALUES (1, 'Fresh products'),
							  (2, 'Refrigerator items'),
                              (3, 'Cellar products'),
                              (4, 'Personal Care Items'),
                              (5, 'Household items'),
                              (6, 'Pet products') ;


CREATE TABLE IF NOT EXISTS `Products` (
  `Barcode` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(4,2)  NULL,
  `P_Name` VARCHAR(45) NULL,
  `Brand_name` BOOLEAN NULL,
  `First_transaction` DATETIME NULL,
  `Category_id` INT UNSIGNED NOT NULL,
  `Is_available` BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (`Barcode`),
    FOREIGN KEY (`Category_id`)
    REFERENCES `Category` (`Category_id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;  
  
CREATE INDEX Barcode_idx ON `Products`(`Barcode`);
CREATE INDEX Price_idx ON `Products`(`Price`);
  
CREATE TABLE IF NOT EXISTS `Older_prices` (
  `Start_date` DATETIME NOT NULL,
  `O_Price` DECIMAL(4,2) NULL,
  `End_date` DATE NULL,
  `P_Barcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Start_date`, `P_Barcode`),
    FOREIGN KEY (`P_Barcode`)
    REFERENCES `Products` (`Barcode`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;
  
CREATE INDEX Start_date_idx ON `Older_prices`(`Start_date`);
  
  
CREATE TABLE IF NOT EXISTS `Customer` (
  `Card#` INT UNSIGNED NOT NULL,
  `Pet` VARCHAR(45) NULL,
  `Family_members` INT NULL,
  `Cust_Street` VARCHAR(45) NULL,
  `Cust_Street_Number` INT NULL,
  `Cust_Postal_code` VARCHAR(45) NULL,
  `Cust_City` VARCHAR(45) NULL,
  `Cust_Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Points` INT UNSIGNED DEFAULT 0,
  `Cust_Phone_number` VARCHAR(45) NULL,
  `Age` INT DEFAULT (YEAR(CURDATE())-YEAR(`Customer`.`Date_of_birth`)),
  `Is_member` INT DEFAULT TRUE,
  PRIMARY KEY (`Card#`) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;
  
CREATE INDEX Card_id_idx ON `Customer`(`Card#`);
CREATE INDEX Age_idx ON `Customer`(`Age`);
CREATE INDEX Is_member_idx ON `Customer`(`Is_member`);
  
CREATE TABLE IF NOT EXISTS `Transaction` (
  `DateTime` DateTime NOT NULL,
  `Payment_method` VARCHAR(45) NULL,
  `Total_amount` DECIMAL(6,2)  NULL DEFAULT 0,
  `Card#` INT UNSIGNED NOT NULL,
  `Store_id` INT UNSIGNED NOT NULL,
  `Total_pieces` INT DEFAULT 0,
  PRIMARY KEY (`DateTime`, `Card#`),
    FOREIGN KEY (`Store_id`)
    REFERENCES `Stores` (`Store_id`),
    FOREIGN KEY (`Card#`)
    REFERENCES `Customer` (`Card#`),
  CHECK (`Payment_method` IN ('Cash', 'Credit card', 'Paypal' )) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;  
        
CREATE INDEX Transaction_idx ON `Transaction`(`DateTime`);

CREATE TABLE IF NOT EXISTS `Contains` (
  `DateTime` DateTime NOT NULL,
  `Card#` INT UNSIGNED NOT NULL,
  `Barcode` VARCHAR(45) NOT NULL,
  `Pieces` INT UNSIGNED NULL,
  PRIMARY KEY (`Barcode`, `DateTime`, `Card#`),
    FOREIGN KEY (`Barcode`)
    REFERENCES `Products` (`Barcode`),
    FOREIGN KEY (`DateTime` , `Card#`)
    REFERENCES `Transaction` (`DateTime` , `Card#`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

CREATE INDEX Pieces_idx ON `Contains`(`Pieces`);

CREATE TABLE IF NOT EXISTS `Provides` (
  `Store_id` INT UNSIGNED NOT NULL,
  `Category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Store_id`, `Category_id`),
  FOREIGN KEY (`Store_id`) REFERENCES `Stores` (`Store_id`),
  FOREIGN KEY (`Category_id`) 
  REFERENCES `Category` (`Category_id`)) 
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;


CREATE TABLE IF NOT EXISTS `Offers` (
  `Alley#` INT UNSIGNED NULL,
  `Shelf#` INT UNSIGNED NULL,
  `Store_id` INT UNSIGNED NOT NULL,
  `Barcode` VARCHAR(45) NOT NULL,
  `Offering_now` BOOLEAN DEFAULT TRUE,
  PRIMARY KEY  (`Store_id`, `Barcode`),
  FOREIGN KEY (`Store_id`)
  REFERENCES `Stores` (`Store_id`),
  FOREIGN KEY (`Barcode`)
  REFERENCES `Products` (`Barcode`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;


CREATE INDEX Offering_idx ON `Offers`(`Offering_now`);