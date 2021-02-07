-- me allo xroniko diasthma

SELECT *
FROM `Transaction`
WHERE `Transaction`.`Store_id` = 4
   and `Transaction`.`DateTime` BETWEEN '2015-07-02' AND '2020-03-04'
   and `Payment_method` = 'Cash'