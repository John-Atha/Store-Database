CREATE VIEW `Sales Categories Stores` AS
SELECT `Products`.`Category_id`, `Transaction`.`Store_id`, SUM(`Pieces`)
FROM `Contains`, `Products`, `Transaction`
WHERE  `Products`.`Barcode` = `Contains`.`Barcode`
   and `Contains`.`DateTime` = `Transaction`.`DateTime`
   and `Contains`.`Card#` = `Transaction`.`Card#`
GROUP BY  `Products`.`Category_id`, `Transaction`.`Store_id` 
order by  `Products`.`Category_id` asc, `Transaction`.`Store_id` asc;

CREATE VIEW `Customers' Info` AS
SELECT *
FROM `Customer`;