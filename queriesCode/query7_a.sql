-- 10 pio dhmofilh proionta gia card#=4

SELECT `List`.`Barcode`
FROM 
	  ( SELECT `Barcode`, sum(`Pieces`) as `Summa`
		FROM `Contains`
		WHERE `Card#` = 4
		GROUP BY `Barcode`
		ORDER BY `Summa` DESC
		LIMIT 10 ) as `List`
