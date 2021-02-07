-- epeleja katasthma 1, PIO DHMOFILEIS THESEIS PROIONTWN

SELECT `Alley#`, `Shelf#`
FROM `Offers`,	(SELECT `Barcode`, SUM(`Pieces`) as `Summa`
				FROM `Contains`
				WHERE 	(`Contains`.`DateTime`,`Contains`.`Card#`)
						in
						(SELECT `DateTime`, `Card#`
						FROM `Transaction`
						WHERE `Store_id` = 1)
				GROUP BY `Contains`.`Barcode`
				ORDER BY `Summa` DESC
				) as `Popular_Barcodes_of_Store_1`
WHERE	`Offers`.`Barcode` = `Popular_Barcodes_of_Store_1`.`Barcode`
LIMIT 10