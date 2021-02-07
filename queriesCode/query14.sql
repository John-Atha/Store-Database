-- epilegoume ta proionta me barcode = 15168, 22753

SELECT `P_Barcode`, `Start_date`, `O_Price`, `End_date`
FROM `Older_Prices`
WHERE `P_Barcode` = '15168'
or `P_Barcode` = '22753'
order by `P_Barcode`