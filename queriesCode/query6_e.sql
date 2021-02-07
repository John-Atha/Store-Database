-- me megalytero periorismo total pieces > 5

SELECT *
FROM `Transaction`
WHERE `Transaction`.`Store_id` = 4
   and `Transaction`.`DateTime` BETWEEN '1980-07-02' AND '2020-03-04'
   and `Payment_method` = 'Cash'
   and `Total_Pieces` > 5
   