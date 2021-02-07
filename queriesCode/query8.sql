-- top ten dhmofilh zeugh proiontwn 

SELECT `final_table`.`Tuple`
FROM
(SELECT `Tuple`, COUNT(`Tuple`) as `COUNTER`
FROM
(SELECT 
( CONCAT (`Tuples_arxika`.`Barcode1`,'-', `Tuples_arxika`.`Barcode2`) ) as `Tuple`
FROM
(SELECT `Contains1`.`Barcode`as `Barcode1`, `Contains2`.`Barcode` as `Barcode2`
FROM `Contains` as `Contains1`, `Contains` as `Contains2`
WHERE	`Contains1`.`DateTime` = `Contains2`.`DateTime`
and		`Contains1`.`Card#` = `Contains2`.`Card#`
and		`Contains1`.`Barcode` > `Contains2`.`Barcode`) as `Tuples_arxika`) as `Table`
GROUP BY `Table`.`Tuple`
ORDER BY `COUNTER` DESC LIMIT 10) as `final_table`



